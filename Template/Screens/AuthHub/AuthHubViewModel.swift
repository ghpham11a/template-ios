//
//  AuthHubViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class AuthHubViewModel: ObservableObject {
    
    @Published var username: String = "gm.pham@gmail.com"
    @Published var isLoading: Bool = false
    @Published var selectedCountryCode = "United States ( +1 )"
    @Published var phoneNumber = ""
    
    func checkIfUserExists(username: String = "", phoneNumber: String = "") async -> (isSuccessful: Bool, userStatus: UserStatus) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        var usernameParam = ""
        var phoneNumberParam = ""
        if username != "" {
            usernameParam = username.lowercased()
        } else {
            phoneNumberParam = phoneNumber
        }
        
        var result = await APIGatewayService.shared.adminReadtUser(username: usernameParam, phoneNumber: phoneNumberParam)
        DispatchQueue.main.async {
            self.isLoading = false
        }
        switch result {
        case .success(let response):
            if response.message == Constants.AWS_COGNITO_USER_DOES_EXIST_MESSAGE {
                if response.data?.enabled == true {
                    return (true, .existsAndEnabled)
                } else {
                    return (true, .existsAndDisabled)
                }
            } else {
                return (true, .doesNotExist)
            }
        case .failure(let error):
            return (false, .doesNotExist)
        }
    }
}
