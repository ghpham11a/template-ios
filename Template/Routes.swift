//
//  Routes.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import Foundation

enum Route: Hashable {
    
    case publicProfile(username: String)
    case editProfile
    case loginSecurity
    case paymentsAndPayouts
    case resetPassword
    case newPassword(username: String, code: String)
    case resetPasswordSuccess
    case snag
    case auth
    case authAddInfo(username: String)
    case authEnterPassword(username: String, status: String)
    case authCodeVerification(verificationType: String, username: String, password: String)
    case stepsGuide
}
