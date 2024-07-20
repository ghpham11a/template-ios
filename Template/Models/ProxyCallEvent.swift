//
//  ProxyCallEvent.swift
//  Template
//
//  Created by Anthony Pham on 7/20/24.
//

import Foundation

struct ProxyCallEvent: Codable {
    var user: DynamoDBUser? = nil
    var proxyCall: ProxyCall? = nil
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case proxyCall = "proxyCall"
    }
}
