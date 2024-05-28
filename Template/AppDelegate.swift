//
//  AppDelegate.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import UIKit
import AWSMobileClient

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AWSMobileClient.default().initialize { (userState, error) in
            if let error = error {
                print("Error initializing AWSMobileClient: \(error.localizedDescription)")
            } else if let userState = userState {
                let defaults = UserDefaults.standard
                let isUserStateSignedIn = userState == UserState.signedIn
                let userDefaultsAuthKeyExists = defaults.object(forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN) != nil
                if (isUserStateSignedIn && !userDefaultsAuthKeyExists) || !isUserStateSignedIn {
                    AWSMobileClient.default().signOut()
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_AUTH_TOKEN)
                }
                _ = UserRepo.shared.isLoggedIn()
            }
        }
        
        return true
    }
    
}


