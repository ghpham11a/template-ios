//
//  Constants.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation

struct Constants {
    
    static let USER_DEFAULTS_KEY_AUTH_TOKEN = "auth_token"
    
    struct Route {
        static let ALPHA_TAB = "alpha_tab"
        static let BRAVO_TAB = "bravo_tab"
        static let CHARLIE_TAB = "charlie_tab"
        static let DELTA_TAB = "delta_tab"
        
        static let SNAG = "snag"
        
        static let AUTH_HUB = "auth/hub"
        static let AUTH_HUB_ROOT = "auth/hub"
        static let AUTH_ADD_INFO = "auth/add_info?username=%@"
        static let AUTH_ADD_INFO_ROOT = "auth/add_info"
        static let AUTH_ENTER_PASSWORD = "auth/enter_password?username=%@"
        static let AUTH_ENTER_PASSWORD_ROOT = "auth/enter_password"
        static let AUTH_CODE_VERIFICATION = "auth/code_verification?username=%@&password=%@"
        static let AUTH_CODE_VERIFICATION_ROOT = "auth/code_verification"
    }
}