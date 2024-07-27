//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @State private var selectedTab = 0 
    @State private var path = NavigationPath()
    
    var appPubs: AppPubs
    
    init(appPubs: AppPubs) {
        self.appPubs = appPubs
    }
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selectedTab) { // Step 2: Bind the state variable
                FeaturesScreen(path: $path)
                    .environmentObject(appPubs)
                    .tabItem {
                        Label("Features", systemImage: "checkmark.circle")
                    }
                    .tag(0) // Assign a unique tag
                    .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
                ProfileScreen(path: $path)
                    .tabItem {
                        Label("Profile", systemImage: "checkmark.circle")
                    }
                    .tag(1) // Assign a unique tag
                    .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            }
        }
        .onOpenURL { incomingURL in
            var params = [String: String]()
            let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: false)
            components?.queryItems?.forEach { item in
                params[item.name] = item.value
            }
            selectedTab = 1
            path.append(Route.mapView)
        }
        .onAppear {
            _ = LocationManager.shared
        }
    }
}

//#Preview {
//    ContentView()
//}
