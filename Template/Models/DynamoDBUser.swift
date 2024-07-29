//
//  DynamoDBUser.swift
//  Template
//
//  Created by Anthony Pham on 7/4/24.
//

import Foundation

struct DynamoDBUser: Codable {
    var userId: String? = nil
    var email: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    var preferredName: String? = nil
    var phoneNumber: String? = nil
    var countryCode: String? = nil
    var stripeCustomerId: String? = nil
    var stripeAccountId: String? = nil
    var tags: [Int]? = nil
    var availabilityType1: [String]? = nil
    var availabilityType2: [String]? = nil
    var availabilityType3: [String]? = nil
    var availabilityType4: [String]? = nil
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case preferredName = "preferredName"
        case phoneNumber = "phoneNumber"
        case countryCode = "countryCode"
        case stripeCustomerId = "stripeCustomerId"
        case stripeAccountId = "stripeAccountId"
        case tags = "tags"
        case availabilityType1 = "availabilityType1"
        case availabilityType2 = "availabilityType2"
        case availabilityType3 = "availabilityType3"
        case availabilityType4 = "availabilityType4"
    }
}
