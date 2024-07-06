//
//  StripeAccount.swift
//  Template
//
//  Created by Anthony Pham on 7/4/24.
//

import Foundation

struct StripeAccount: Codable {
    var payoutsEnabled: Bool? = nil
    var disabledReason: String? = nil
    var accountLinkUrl: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case payoutsEnabled = "payoutsEnabled"
        case disabledReason = "disabledReason"
        case accountLinkUrl = "accountLinkUrl"
    }
}
