//
//  CreateSetupIntentResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/27/24.
//

import Foundation

struct CreateSetupIntentResponse: Codable {
    let isSuccessful: Bool?
    let stripeCustomerId: String?
    let ephemeralKey: String?
    let setupIntent: String?
    let publishableKey: String?
    
    enum CodingKeys: String, CodingKey {
        case isSuccessful = "isSuccessful"
        case stripeCustomerId = "stripeCustomerId"
        case ephemeralKey = "ephemeralKey"
        case setupIntent = "setupIntent"
        case publishableKey = "publishableKey"
    }
}
