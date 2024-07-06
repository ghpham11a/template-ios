//
//  ReadUserResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import Foundation

struct ReadUserPrivateResponse: Codable {
    var user: DynamoDBUser? = nil
    var stripeAccount: StripeAccount? = nil

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case stripeAccount = "stripeAccount"
    }
}
