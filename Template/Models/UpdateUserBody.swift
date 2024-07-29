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
    var updateAvailability: UpdateAvailability? = nil
    var updateTags: UpdateTags? = nil
    
    // Profile
    var updateSchool: UpdateSchool? = nil
    
    enum CodingKeys: String, CodingKey {
        case updateImage = "updateImage"
        case updateLegalName = "updateLegalName"
        case updatePreferredName = "updatePreferredName"
        case updatePhoneNumber = "updatePhoneNumber"
        case updateSchool = "updateSchool"
        case updateEmail = "updateEmail"
        case updateAvailability = "updateAvailability"
        case updateTags = "updateTags"
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

struct UpdateAvailability: Codable {
    let availabilityType1: [String]
    let availabilityType2: [String]
    let availabilityType3: [String]
    let availabilityType4: [String]
    
    enum CodingKeys: String, CodingKey {
        case availabilityType1 = "availabilityType1"
        case availabilityType2 = "availabilityType2"
        case availabilityType3 = "availabilityType3"
        case availabilityType4 = "availabilityType4"
    }
}

struct UpdateTags: Codable {
    let tags: [Int]
    
    enum CodingKeys: String, CodingKey {
        case tags = "tags"
    }
}
