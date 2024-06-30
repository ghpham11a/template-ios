//
//  PaymentMethod.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import Foundation

struct PaymentMethod: Codable {
    var id: String? = nil
    var type: String? = nil
    var brand: String? = nil
    var last4: String? = nil
    var expMonth: String? = nil
    var expYear: Int? = nil
    var status: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case brand = "brand"
        case last4 = "last4"
        case expMonth = "expMonth"
        case expYear = "expYear"
    }
}
