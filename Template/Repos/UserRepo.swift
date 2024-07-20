//
//  UserRepo.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation
import AWSMobileClient

enum UserStatus {
    case existsAndEnabled
    case existsAndDisabled
    case doesNotExist
}

class UserRepo: ObservableObject {
    
    static let shared = UserRepo()
    
    @Published var isAuthenticated: Bool = false
    @Published var imageRefreshId: String = ""
    
    var userStatus: UserStatus = .doesNotExist
    
    var userId: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_SUB) as? String
    }
    var idToken: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN) as? String
    }
    var accessToken: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN) as? String
    }
    var username: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_USERNAME) as? String
    }
    var firstName: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_FIRSTNAME) as? String
    }
    var lastName: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_LASTNAME) as? String
    }
    var birthDate: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_BIRTHDATE) as? String
    }
    var expirationDate: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE) as? String
    }
    
    var userPrivate: ReadUserPrivateResponse? = nil
    var userPublic: ReadUserPublicResponse? = nil
    
    func privateReadUser(userSub: String, refresh: Bool = false) async -> APIResponse<ReadUserPrivateResponse> {
        if let safeUserPrivate = userPrivate, refresh == false {
            return .success(safeUserPrivate)
        }
        
        let response = await APIGatewayService.shared.privateReadUser(userSub: userSub)
        switch response {
        case .success(let response):
            userPrivate = response
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func publicReadUser(userSub: String) async -> APIResponse<ReadUserPublicResponse> {
        
        if let safeUserPublic = userPublic {
            return .success(safeUserPublic)
        }
        
        let response = await APIGatewayService.shared.publicReadUser(userSub: userSub)
        switch response {
        case .success(let response):
            userPublic = response
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func createAZCSAccessToken(refresh: Bool) async -> APIResponse<CreateAZCSAccessTokenResponse> {
        
        if let safeUserPrivate = userPrivate, refresh == false {
            return .success(CreateAZCSAccessTokenResponse())
        }
    
        let response = await APIGatewayService.shared.azcsCreateAccessToken()
        switch response {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func isLoggedIn() -> Bool {
        
        let defaults = UserDefaults.standard
        DispatchQueue.main.async {
            if defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN) != nil {
                self.isAuthenticated = true
            } else {
                self.isAuthenticated = false
            }
        }
        return isAuthenticated
    }
    
    func setLoggedIn(tokens: Tokens, username: String, userAttributes: [String: String]) {
        let defaults = UserDefaults.standard
        
        guard let idToken = tokens.idToken, let accessToken = tokens.accessToken, let expiration = tokens.expiration else {
            return
        }
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let expirationDate = dateFormatter.string(from: expiration)
        
        defaults.updateUserId(value: userAttributes["sub"] ?? "")
        defaults.updateIdToken(value: idToken.tokenString ?? "")
        defaults.updateAccessToken(value: accessToken.tokenString ?? "")
        defaults.updateEmail(value: userAttributes["email"] ?? "")
        defaults.updateFirstName(value: userAttributes["given_name"] ?? "")
        defaults.updateLastName(value: userAttributes["family_name"] ?? "")
        defaults.updateBirthdate(value: userAttributes["birthdate"] ?? "")
        defaults.updateExpirationDate(value: expirationDate)
        
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }
    
    func updateUser(key: String, value: String) {
        let defaults = UserDefaults.standard
        switch (key) {
        case Constants.USER_DEFAULTS_KEY_SUB:
            defaults.updateUserId(value: value)
        case Constants.USER_DEFAULTS_KEY_ID_TOKEN:
            defaults.updateIdToken(value: value)
        case Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN:
            defaults.updateAccessToken(value: value)
        case Constants.USER_DEFAULTS_KEY_USERNAME:
            defaults.updateEmail(value: value)
        case Constants.UserAttributes.FirstName:
            userPrivate?.user?.firstName = value
        case Constants.UserAttributes.LastName:
            userPrivate?.user?.lastName = value
        case Constants.UserAttributes.PreferredName:
            userPrivate?.user?.preferredName = value
        case Constants.USER_DEFAULTS_KEY_BIRTHDATE:
            defaults.updateBirthdate(value: value)
        case Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE:
            defaults.updateExpirationDate(value: value)
        default:
            break
        }
    }

    func logOut() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        let defaults = UserDefaults.standard
        defaults.removeValues()
    }
    
}
