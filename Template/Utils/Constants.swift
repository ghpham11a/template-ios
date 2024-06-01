//
//  Constants.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation

struct Constants {
    
    static let USER_DEFAULTS_KEY_ID_TOKEN = "id_token"
    static let USER_DEFAULTS_KEY_ACCESS_TOKEN = "access_token"
    static let USER_DEFAULTS_KEY_USERNAME = "username"
    static let USER_DEFAULTS_KEY_EXPIRATION_DATE = "expiration_date"
    static let INTERNAL_DATE_PATTERN = "yyyy-MM-dd HH:mm:ss"
    static let AWS_COGNITO_USER_DOES_EXIST_MESSAGE = "User exists"
    static let AWS_COGNITO_USER_DOES_NOT_EXIST_MESSAGE = "User does not exist"
    
    struct Route {
        static let ALPHA_TAB = "alpha_tab"
        static let BRAVO_TAB = "bravo_tab"
        static let CHARLIE_TAB = "charlie_tab"
        static let DELTA_TAB = "delta_tab"
        
        static let SNAG = "snag"
        
        static let AUTH_HUB = "auth/hub"
        static let AUTH_ADD_INFO = "auth/add_info?username=%@"
        static let AUTH_ENTER_PASSWORD = "auth/enter_password?username=%@&status=%@"
        static let AUTH_CODE_VERIFICATION = "auth/code_verification?username=%@&password=%@"
    }
}
