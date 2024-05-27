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
                _ = UserRepo.shared.isLoggedIn()
                print("AWSMobileClient initialized. Current UserState: \(userState.rawValue)")
            }
        }
        
        return true
    }
    
}


