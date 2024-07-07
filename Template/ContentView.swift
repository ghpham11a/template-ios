//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

class DeepLinkManager: ObservableObject {
    @Published var params: [String: String] = [:]
    
    func handleDeepLink(params: [String: String]) {
        self.params = params
    }
}

struct ContentView: View {
    
    // @EnvironmentObject var deepLinkManager: DeepLinkManager
    @StateObject var locationManager = LocationManager.shared
    @State private var selectedTab = 0 
    @State private var path = NavigationPath()
    
    var body: some View {
        
        TabView(selection: $selectedTab) { // Step 2: Bind the state variable
            HomeScreen(path: $path)
                .tabItem {
                    Label("Home", systemImage: "person.3")
                }
                .tag(0) // Assign a unique tag for each tab
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            FeaturesScreen(path: $path)
                .tabItem {
                    Label("Features", systemImage: "checkmark.circle")
                }
                .tag(1) // Assign a unique tag
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            ProfileScreen(path: $path)
                .tabItem {
                    Label("Profile", systemImage: "checkmark.circle")
                }
                .tag(2) // Assign a unique tag
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
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
    }
}

//#Preview {
//    ContentView()
//}
