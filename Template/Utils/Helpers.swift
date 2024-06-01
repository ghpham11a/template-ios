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
}

struct RegisteredParams {
    var username: String = ""
    var password: String = ""
    var status: String = ""
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
    if urlString.contains("auth/code_verification") {
        registeredRoute = .codeVerification
    }
    if urlString.contains("snag") {
        registeredRoute = .snag
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
                default:
                    continue
                }
            }
        }
    }
    
    return (route: registeredRoute ,params: params)
}
