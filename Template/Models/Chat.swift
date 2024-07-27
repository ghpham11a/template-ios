//
//  Chat.swift
//  Template
//
//  Created by Anthony Pham on 7/26/24.
//

import Foundation

struct Chat: Codable {
    var id: String? = nil
    var senderId: String? = nil
    var receiverId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case senderId = "senderId"
        case receiverId = "receiverId"
    }
}
