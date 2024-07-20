//
//  ChatEvent.swift
//  Template
//
//  Created by Anthony Pham on 7/20/24.
//

import Foundation

struct ChatEvent: Codable {
    var user: DynamoDBUser? = nil
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}
