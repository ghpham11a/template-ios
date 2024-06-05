//
//  Helpers.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import Foundation

enum RegisteredRoute {
    case authHub
    case addNewUserInfo
    case enterPassword
    case codeVerification
    case snag
    case public_profile
    case edit_profile
    case login_and_security
    case payments_and_payouts
    case reset_password
    case newPassword
    case resetPasswordSuccess
}

struct RegisteredParams {
    var username: String = ""
    var password: String = ""
    var status: String = ""
    var verificationType: String = ""
    var code: String = ""
}

func parseRouteParams(from urlString: String) -> (route: RegisteredRoute, params: RegisteredParams)? {
    var params = RegisteredParams()
    
    var registeredRoute: RegisteredRoute = .snag
    
    if urlString.contains("auth/hub") {
        registeredRoute = .authHub
    }
    if urlString.contains("auth/enter_password") {
        registeredRoute = .enterPassword
    }
    if urlString.contains("auth/add_info") {
        registeredRoute = .addNewUserInfo
    }
    if urlString.contains("profile_tab/public_profile") {
        registeredRoute = .public_profile
    }
    if urlString.contains("profile_tab/edit_profile") {
        registeredRoute = .edit_profile
    }
    if urlString.contains("snag") {
        registeredRoute = .snag
    }
    if urlString.contains("auth/code_verification") {
        registeredRoute = .codeVerification
    }
    if urlString.contains("snag") {
        registeredRoute = .snag
    }
    if urlString.contains("profile_tab/login_and_security") {
        registeredRoute = .login_and_security
    }
    if urlString.contains("profile_tab/payments_and_payouts") {
        registeredRoute = .payments_and_payouts
    }
    if urlString.contains("auth/hub/reset_password") {
        registeredRoute = .reset_password
    }
    if urlString.contains("auth/new_password") {
        registeredRoute = .newPassword
    }
    if urlString.contains("reset_password_success") {
        registeredRoute = .resetPasswordSuccess
    }
    
    // Separate the URL components
    guard let urlComponents = URLComponents(string: urlString) else {
        return nil
    }
    
    // Extract the query items
    if let queryItems = urlComponents.queryItems {
        for item in queryItems {
            if let value = item.value {
                switch item.name {
                case "username":
                    params.username = value
                case "password":
                    params.password = value
                case "status":
                    params.status = value
                case "verificationType":
                    params.verificationType = value
                case "code":
                    params.code = value
                default:
                    continue
                }
            }
        }
    }
    
    return (route: registeredRoute ,params: params)
}
