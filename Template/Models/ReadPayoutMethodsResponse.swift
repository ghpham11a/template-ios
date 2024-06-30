//
//  ReadPayoutMethodsRedsponse.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import Foundation

struct ReadPayoutMethodsResponse: Codable {
    var payoutMethods: [PayoutMethod]? = nil
    
    enum CodingKeys: String, CodingKey {
        case payoutMethods = "payoutMethods"
    }
}
