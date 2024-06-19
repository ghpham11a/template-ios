//
//  CreateThingResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/18/24.
//

import Foundation

struct CreateThingResponse: Codable {
    let message: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case error = "error"
    }
}
