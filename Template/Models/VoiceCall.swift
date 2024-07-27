//
//  VoiceCall.swift
//  Template
//
//  Created by Anthony Pham on 7/26/24.
//

import Foundation

struct VoiceCall: Codable {
    var id: String? = nil
    
    var senderId: String? = nil
    var senderIdentity: String? = nil
    var senderToken: String? = nil
    var senderTokenExpiresOn: String? = nil
    
    var receiverId: String? = nil
    var receiverIdentity: String? = nil
    var receiverToken: String? = nil
    var receiverTokenExpiresOn: String? = nil

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        
        case senderId = "senderId"
        case senderIdentity = "senderIdentity"
        case senderToken = "senderToken"
        case senderTokenExpiresOn = "senderTokenExpiresOn"
        
        case receiverId = "receiverId"
        case receiverIdentity = "receiverIdentity"
        case receiverToken = "receiverToken"
        case receiverTokenExpiresOn = "receiverTokenExpiresOn"
    }
}
