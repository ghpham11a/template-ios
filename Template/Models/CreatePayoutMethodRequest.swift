//
//  CreatePayoutMethodRequest.swift
//  Template
//
//  Created by Anthony Pham on 6/30/24.
//

import Foundation

struct CreatePayoutMethodRequest: Codable {
    var route: String?
    var customerId: String?
    var accountId: String?
    
    enum CodingKeys: String, CodingKey {
        case route = "route"
        case customerId = "customerId"
        case accountId = "accountId"
    }
}
