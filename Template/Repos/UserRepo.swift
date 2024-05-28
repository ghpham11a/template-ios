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
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }

    func logOut() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN)
    }
    
}
