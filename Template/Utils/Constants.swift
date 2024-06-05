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
    static let USER_DEFAULTS_KEY_SUB = "sub"
    static let INTERNAL_DATE_PATTERN = "yyyy-MM-dd HH:mm:ss"
    static let AWS_COGNITO_USER_DOES_EXIST_MESSAGE = "User exists"
    static let AWS_COGNITO_USER_DOES_NOT_EXIST_MESSAGE = "User does not exist"
    
    static let USER_IMAGE_URL = "https://template-public-resources.s3.amazonaws.com/%@.jpg"
    
    struct Route {
        static let HOME_TAB = "home_tab"
        static let FEATURES_TAB = "features_tab"
        static let PROFILE_TAB = "profile_tab"
        
        static let PUBLIC_PROFILE = "profile_tab/public_profile?username=%@"
        static let EDIT_PROFILE = "profile_tab/edit_profile"
        
        static let LOGIN_SECURITY = "profile_tab/login_and_security"
        static let PAYMENTS_AND_PAYOUTS = "profile_tab/payments_and_payouts"
        static let RESET_PASSWORD = "auth/hub/reset_password"
        static let NEW_PASSWORD = "auth/new_password?username=%@&code=%@"
        
        static let RESET_PASSWORD_SUCCESS = "reset_password_success"
        
        static let SNAG = "snag"
        
        static let AUTH_HUB = "auth/hub"
        static let AUTH_ADD_INFO = "auth/add_info?username=%@"
        static let AUTH_ENTER_PASSWORD = "auth/enter_password?username=%@&status=%@"
        static let AUTH_CODE_VERIFICATION = "auth/code_verification?verificationType=%@&username=%@&password=%@"
    }
}
