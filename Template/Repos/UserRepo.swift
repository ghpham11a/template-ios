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
    
    var username: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_USERNAME) as? String
    }
    
    var idToken: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN) as? String
    }
    
    var userSub: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_SUB) as? String
    }
    
    var userPrivate: ReadUserPrivateResponse? = nil
    var userPublic: ReadUserPublicResponse? = nil
    
    func privateReadUser(userSub: String) async -> APIResponse<ReadUserPrivateResponse> {
        if let safeUserPrivate = userPrivate {
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
    
    func setLoggedIn(tokens: Tokens, username: String, userSub: String) {
        let defaults = UserDefaults.standard
        
        guard let idToken = tokens.idToken, let accessToken = tokens.accessToken, let expiration = tokens.expiration else {
            return
        }
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let expirationDate = dateFormatter.string(from: expiration)
        
        defaults.set(idToken.tokenString, forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN)
        defaults.set(accessToken.tokenString, forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN)
        defaults.set(username, forKey: Constants.USER_DEFAULTS_KEY_USERNAME)
        defaults.set(expirationDate, forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE)
        defaults.set(userSub, forKey: Constants.USER_DEFAULTS_KEY_SUB)
        
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }

    func logOut() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN)
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN)
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_USERNAME)
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE)
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_SUB)
    }
    
}
