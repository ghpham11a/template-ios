//
//  ReadVoiceCalls.swift
//  Template
//
//  Created by Anthony Pham on 7/26/24.
//

import Foundation

struct ReadVoiceCallsResponse: Codable {
    var calls: [VoiceCall]? = nil
    
    enum CodingKeys: String, CodingKey {
        case calls = "calls"
    }
}
