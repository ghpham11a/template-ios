//
//  Thing.swift
//  Template
//
//  Created by Anthony Pham on 6/16/24.
//

import Foundation

struct Thing: Codable {
    var thingType: ThingType? = nil
    var thingDescription: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case thingType = "thingType"
        case thingDescription = "thingDescription"
    }
}
