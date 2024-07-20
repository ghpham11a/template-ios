//
//  ReadUsers.swift
//  Template
//
//  Created by Anthony Pham on 7/18/24.
//

import Foundation

struct ReadUsersResponse: Codable {
    var users: [DynamoDBUser]? = nil
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
    }
}
