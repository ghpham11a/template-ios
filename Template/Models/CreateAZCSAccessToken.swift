//
//  CreateAZCSAccessToken.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import Foundation

struct CreateAZCSAccessTokenResponse: Codable {
    var token: String? = nil
    var identity: String? = nil
    var expiresOn: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case identity = "identity"
        case expiresOn = "expiresOn"
    }
}
