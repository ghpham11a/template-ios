//
//  AdminDeleteUserResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import Foundation

struct AdminDeleteUserResponse: Codable {
    let message: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case error = "error"
    }
}
