//
//  CreatePayoutMethodRequest.swift
//  Template
//
//  Created by Anthony Pham on 6/30/24.
//

import Foundation

struct CreatePayoutMethodRequest: Codable {
    var route: String?
    // User stuff
    var customerId: String?
    var accountId: String?
    // Stripe stuff
    var accountHolderName: String?
    var accountNumber: String?
    var country: String?
    var currency: String?
    var routingNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case route = "route"
        case customerId = "customerId"
        case accountId = "accountId"
        case accountHolderName = "accountHolderName"
        case accountNumber = "accountNumber"
        case country = "country"
        case currency = "currency"
        case routingNumber = "routingNumber"
    }
}
