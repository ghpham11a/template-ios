//
//  UpdateUserPrivateResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/20/24.
//

import Foundation

struct UpdateUserPrivateResponse: Codable {
    let message: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case error = "error"
    }
}
