//
//  CheckIfUserExistsResponse.swift
//  Template
//
//  Created by Anthony Pham on 5/30/24.
//

import Foundation

struct AdminReadUserResponse: Codable {
    let message: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case error = "error"
    }
}
