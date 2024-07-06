//
//  Routes.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import SwiftUI

enum Route: Hashable, Codable {
    
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
    case thing(thingId: String)
    case thingIntro
    case thingBuilder(thingId: String, action: String, mode: String, steps: String)
    case filterList
    case personalInfo
    case paymentsHub
    case paymentMethods
    case yourPayments
    case payoutMethods
    case uikitView
    case mapView
    case addPayout
    case addBankInfo(country: String)
}
