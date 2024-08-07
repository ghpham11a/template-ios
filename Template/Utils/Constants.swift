//
//  Constants.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation

struct Constants {
    
    struct UserAttributes {
        static let UserId = "userId"
        static let Email = "email"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let PreferredName = "preferredName"
    }
    
    static let USER_DEFAULTS_KEY_SUB = "sub"
    static let USER_DEFAULTS_KEY_ID_TOKEN = "id_token"
    static let USER_DEFAULTS_KEY_ACCESS_TOKEN = "access_token"
    static let USER_DEFAULTS_KEY_USERNAME = "username"
    static let USER_DEFAULTS_KEY_FIRSTNAME = "given_name"
    static let USER_DEFAULTS_KEY_LASTNAME = "family_name"
    static let USER_DEFAULTS_KEY_BIRTHDATE = "birthdate"
    static let USER_DEFAULTS_KEY_EXPIRATION_DATE = "expiration_date"

    static let INTERNAL_DATE_PATTERN = "yyyy-MM-dd HH:mm:ss"
    static let AWS_COGNITO_USER_DOES_EXIST_MESSAGE = "User exists"
    static let AWS_COGNITO_USER_DOES_NOT_EXIST_MESSAGE = "User does not exist"
    
    static let USER_IMAGE_URL = "https://template-public-resources.s3.amazonaws.com/%@.jpg"
    
    
    struct ThingScreen {
        static let THING_TYPE = "THING_TYPE"
        static let THING_DESCRIPTION = "THING_DESCRIPTION"
        static let THING_METHODS = "THING_METHODS"
        static let THING_LOCATION = "THING_LOCATION"
        static let THING_TIME = "THING_TIME"
    }
}
