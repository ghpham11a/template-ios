//
//  ReadPaymentMethodsResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import Foundation

struct ReadPaymentMethodsResponse: Codable {
    var paymentMethods: [PaymentMethod]? = nil
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "paymentMethods"
    }
}
