//
//  ThingType.swift
//  Template
//
//  Created by Anthony Pham on 6/16/24.
//

import Foundation

struct ThingType: Codable {
    let group: String
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case group = "group"
        case title = "title"
        case description = "description"
    }
}
