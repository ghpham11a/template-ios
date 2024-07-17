//
//  CreatePaymentIntent.swift
//  Template
//
//  Created by Anthony Pham on 7/14/24.
//

import Foundation

struct CreatePaymentIntentRequest: Codable {
    var customerId: String? = nil
    var accountId: String? = nil
    var amount: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customerId"
        case accountId = "accountId"
        case amount = "amount"
    }
}


struct CreatePaymentIntentResponse: Codable {

}

