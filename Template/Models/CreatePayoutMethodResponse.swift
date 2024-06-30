//
//  CreatePayoutMethodResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/30/24.
//

import Foundation

struct CreatePayoutMethodResponse: Codable {
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
