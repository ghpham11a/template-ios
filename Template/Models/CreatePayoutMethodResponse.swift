//
//  CreatePayoutMethodResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/30/24.
//

import Foundation

struct CreatePayoutMethodResponse: Codable {
    var id: String?
    var accountHolderName: String?
    var accountHolderType: String?
    var bankName: String?
    var country: String?
    var currency: String?
    var last4: String?
    var routingNumber: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountHolderName = "accountHolderName"
        case accountHolderType = "accountHolderType"
        case bankName = "bankName"
        case country = "country"
        case currency = "currency"
        case last4 = "last4"
        case routingNumber = "routingNumber"
        case status = "status"
    }
}
