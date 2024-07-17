//
//  PaymentReceiver.swift
//  Template
//
//  Created by Anthony Pham on 7/13/24.
//

import Foundation

struct PaymentReceiver: Codable {
    var accountId: String? = nil
    var email: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case accountId = "accountId"
        case email = "email"
    }
}

