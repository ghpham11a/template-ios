//
//  AppDelegate.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import AWSMobileClient
import Stripe
import UIKit
import PushKit
import SwiftUI
import Combine
import AzureCommunicationCalling

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, PKPushRegistryDelegate {
    
    let appPubs = AppPubs()
    
    var voipRegistry: PKPushRegistry = PKPushRegistry(queue:DispatchQueue.main)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let path = Bundle.main.path(forResource: "Properties", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] {
            if let stripePublishableKey = dictionary["STRIPE_API_KEY"] as? String {
                StripeAPI.defaultPublishableKey = stripePublishableKey
                STPAPIClient.shared.publishableKey = stripePublishableKey
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
                    defaults.removeValues()
                }
                _ = UserRepo.shared.isLoggedIn()
            }
        }
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                
                if (granted)
                {
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                }
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Create a push registry object
        // Set the registry's delegate to self
        voipRegistry.delegate = self
        // Set the push type to VoIP
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        appPubs.pushToken = registry.pushToken(for: .voIP) ?? nil
    }
    
    // Handle incoming pushes
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        let callNotification = PushNotificationInfo.fromDictionary(payload.dictionaryPayload)
        let callKitOptions = CallKitOptions(with: CallKitHelper.createCXProvideConfiguration())
        CallClient.reportIncomingCall(with: callNotification, callKitOptions: callKitOptions) { error in
            if error == nil {
                self.appPubs.pushPayload = payload
            }
        }
    }
}
