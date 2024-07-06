//
//  DeletePayoutMethod.swift
//  Template
//
//  Created by Anthony Pham on 7/5/24.
//

import Foundation

struct DeletePayoutMethodRequest: Codable {
    var accountId: String? = nil
    var payoutMethodId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case accountId = "accountId"
        case payoutMethodId = "payoutMethodId"
    }
}

struct DeletePayoutMethodResponse: Codable {
    var message: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
