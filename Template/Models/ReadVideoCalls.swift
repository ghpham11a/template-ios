//
//  ReadVideoCalls.swift
//  Template
//
//  Created by Anthony Pham on 7/22/24.
//

import Foundation

struct ReadVideoCallsResponse: Codable {
    var calls: [VideoCall]? = nil
    
    enum CodingKeys: String, CodingKey {
        case calls = "calls"
    }
}
