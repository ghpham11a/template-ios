//
//  ProxyCall.swift
//  Template
//
//  Created by Anthony Pham on 7/15/24.
//

import Foundation

struct ProxyCall: Codable {
    var id: String? = nil
    var senderId: String? = nil
    var receiverId: String? = nil
    var senderProxy: String? = nil
    var receiverProxy: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case senderId = "senderId"
        case receiverId = "receiverId"
        case senderProxy = "senderProxy"
        case receiverProxy = "receiverProxy"
    }
}
