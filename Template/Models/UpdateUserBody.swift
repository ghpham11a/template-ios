//
//  UpdateUserBody.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import Foundation

struct UpdateUserBody: Codable {
    // Personal info
    var updateImage: UpdateImage? = nil
    var updateLegalName: UpdateLegalName? = nil
    var updatePreferredName: UpdatePreferredName? = nil
    var updatePhoneNumber: UpdatePhoneNumber? = nil
    var updateEmail: UpdateEmail? = nil
    
    // Profile
    var updateSchool: UpdateSchool? = nil
    
    enum CodingKeys: String, CodingKey {
        case updateImage = "updateImage"
        case updateLegalName = "updateLegalName"
        case updatePreferredName = "updatePreferredName"
        case updatePhoneNumber = "updatePhoneNumber"
        case updateSchool = "updateSchool"
        case updateEmail = "updateEmail"
    }
}

struct UpdateImage: Codable {
    let imageData: String

    enum CodingKeys: String, CodingKey {
        case imageData = "imageData"
    }
}

struct UpdateLegalName: Codable {
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
    }
}

struct UpdatePreferredName: Codable {
    let preferredName: String

    enum CodingKeys: String, CodingKey {
        case preferredName = "preferredName"
    }
}

struct UpdatePhoneNumber: Codable {
    let countryCode: String
    let phoneNumber: String
    let username: String

    enum CodingKeys: String, CodingKey {
        case countryCode = "countryCode"
        case phoneNumber = "phoneNumber"
        case username = "username"
    }
}

struct UpdateSchool: Codable {
    let schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "schoolName"
    }
}

struct UpdateEmail: Codable {
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
