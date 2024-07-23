//
//  CreateVideoCall.swift
//  Template
//
//  Created by Anthony Pham on 7/22/24.
//

import Foundation

struct CreateVideoCallRequest: Codable {
    var senderId: String? = nil
    var receiverId: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case senderId = "senderId"
        case receiverId = "receiverId"
    }
}

struct CreateVideoCallResponse: Codable {
    var message: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
