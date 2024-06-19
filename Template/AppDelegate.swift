//
//  AppDelegate.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import AWSMobileClient
import Stripe
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let path = Bundle.main.path(forResource: "Properties", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] {
            if let stripePublishableKey = dictionary["STRIPE_API_KEY"] as? String {
                StripeAPI.defaultPublishableKey = stripePublishableKey
            }
        }
        
        AWSMobileClient.default().initialize { (userState, error) in
            if let error = error {
                print("Error initializing AWSMobileClient: \(error.localizedDescription)")
            } else if let userState = userState {
                let defaults = UserDefaults.standard
                let isUserStateSignedIn = userState == UserState.signedIn
                let userDefaultsAuthKeyExists = defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN) != nil
                if (isUserStateSignedIn && !userDefaultsAuthKeyExists) || !isUserStateSignedIn {
                    AWSMobileClient.default().signOut()
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN)
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_ACCESS_TOKEN)
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_USERNAME)
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_EXPIRATION_DATE)
                    defaults.removeObject(forKey: Constants.USER_DEFAULTS_KEY_SUB)
                }
                _ = UserRepo.shared.isLoggedIn()
            }
        }
        
        return true
    }
    
}


