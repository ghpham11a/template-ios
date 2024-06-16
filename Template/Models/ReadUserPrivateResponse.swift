//
//  ReadUserResponse.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import Foundation

struct ReadUserPrivateResponse: Codable {
    var userId: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var countryCode: String?
    var phoneNumber: String?
    var preferredName: String?

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case countryCode = "countryCode"
        case phoneNumber = "phoneNumber"
        case preferredName = "preferredName"
    }
}
