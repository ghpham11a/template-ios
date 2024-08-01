//
//  ReadUserPublicResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/15/24.
//

import Foundation

struct ReadUserPublicResponse: Codable {
    var schoolName: String?
    var tags: [Int]?
    var availabilityType1: [String]? = nil
    var availabilityType2: [String]? = nil
    var availabilityType3: [String]? = nil
    var availabilityType4: [String]? = nil

    enum CodingKeys: String, CodingKey {
        case schoolName = "schoolName"
        case tags = "tags"
        case availabilityType1 = "availabilityType1"
        case availabilityType2 = "availabilityType2"
        case availabilityType3 = "availabilityType3"
        case availabilityType4 = "availabilityType4"
    }
}
