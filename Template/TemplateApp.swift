//
//  TemplateApp.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

@main
struct TemplateApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
