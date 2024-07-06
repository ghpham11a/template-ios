//
//  DeletePaymentMethod.swift
//  Template
//
//  Created by Anthony Pham on 7/5/24.
//

import Foundation

struct DeletePaymentMethodRequest: Codable {
    var accountId: String? = nil
    var paymentMethodId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case accountId = "accountId"
        case paymentMethodId = "paymentMethodId"
    }
}

struct DeletePaymentMethodResponse: Codable {
    var message: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
