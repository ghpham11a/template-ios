//
//  ReadUserPublicResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/15/24.
//

import Foundation

struct ReadUserPublicResponse: Codable {
    var schoolName: String?

    enum CodingKeys: String, CodingKey {
        case schoolName = "schoolName"
    }
}
