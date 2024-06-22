//
//  UserDefaults+Extension.swift
//  Template
//
//  Created by Anthony Pham on 6/22/24.
//

import Foundation

extension UserDefaults {
    
    func updateUserId(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_SUB)
    }
    func updateIdToken(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN)
    }
    func updateAccessToken(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN)
    }
    func updateEmail(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_USERNAME)
    }
    func updateLastName(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_LASTNAME)
    }
    func updateFirstName(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_FIRSTNAME)
    }
    func updateBirthdate(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_BIRTHDATE)
    }
    func updateExpirationDate(value: String) {
        self.set(value, forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE)
    }
    
    func removeValues() {
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_SUB)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_USERNAME)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_FIRSTNAME)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_LASTNAME)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_BIRTHDATE)
        self.removeObject(forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE)
    }
}
