//
//  CreateSetupIntentRequest.swift
//  Template
//
//  Created by Anthony Pham on 6/27/24.
//

import Foundation

struct CreateSetupIntentRequest: Codable {
    let stripeCustomerId: String?
    
    enum CodingKeys: String, CodingKey {
        case stripeCustomerId = "stripeCustomerId"
    }
}
