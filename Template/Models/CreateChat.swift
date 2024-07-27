//
//  CreateChat.swift
//  Template
//
//  Created by Anthony Pham on 7/26/24.
//

import Foundation

struct CreateChatRequest: Codable {
    var senderId: String? = nil
    var receiverId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case senderId = "senderId"
        case receiverId = "receiverId"
    }
}

struct CreateChatResponse: Codable {
    var message: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
