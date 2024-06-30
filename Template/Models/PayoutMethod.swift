//
//  PayoutMethod.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import Foundation

struct PayoutMethod: Codable {
    var id: String? = nil
    var accountHolderName: String? = nil
    var accountHolderType: String? = nil
    var country: String? = nil
    var currency: String? = nil
    var last4: String? = nil
    var status: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountHolderName = "accountHolderName"
        case accountHolderType = "accountHolderType"
        case country = "country"
        case currency = "currency"
        case last4 = "last4"
        case status = "status"
    }
}
