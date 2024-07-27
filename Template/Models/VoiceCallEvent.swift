//
//  VoiceCallEvent.swift
//  Template
//
//  Created by Anthony Pham on 7/27/24.
//

import Foundation

struct VoiceCallEvent: Codable {
    var user: DynamoDBUser? = nil
    var voiceCall: VoiceCall? = nil
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case voiceCall = "voiceCall"
    }
}
