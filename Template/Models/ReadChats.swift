//
//  ReadChats.swift
//  Template
//
//  Created by Anthony Pham on 7/26/24.
//

import Foundation

struct ReadChatsResponse: Codable {
    var chats: [Chat]? = nil
    
    enum CodingKeys: String, CodingKey {
        case chats = "chats"
    }
}
