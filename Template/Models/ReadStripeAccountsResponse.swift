//
//  ReadStripeAccountsResponse.swift
//  Template
//
//  Created by Anthony Pham on 7/13/24.
//

import Foundation

struct ReadStripeAccountsResponse: Codable {
    var accounts: [PaymentReceiver]? = nil
    
    enum CodingKeys: String, CodingKey {
        case accounts = "accounts"
    }
}
