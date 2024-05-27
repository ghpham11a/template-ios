//
//  UserRepo.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation

class UserRepo: ObservableObject {
    
    static let shared = UserRepo()
    
    @Published var isAuthenticated: Bool = false

    func isLoggedIn() -> Bool {
        let defaults = UserDefaults.standard
        DispatchQueue.main.async {
            if defaults.object(forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN) != nil {
                self.isAuthenticated = true
            } else {
                self.isAuthenticated = false
            }
        }
        return isAuthenticated
    }
    
    func setLoggedIn(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN)
    }

    func logOut() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN)
    }
    
}
