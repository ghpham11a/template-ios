//
//  CreateProxyCall.swift
//  Template
//
//  Created by Anthony Pham on 7/20/24.
//

import Foundation

struct CreateProxyCallRequest: Codable {
    var senderId: String? = nil
    var receiverId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case senderId = "senderId"
        case receiverId = "receiverId"
    }
}

struct CreateProxyCallResponse: Codable {
    var message: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
