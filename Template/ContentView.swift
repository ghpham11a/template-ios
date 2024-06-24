//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager.shared
    @State private var path = NavigationPath()
    
    var body: some View {
        
        TabView {
            HomeScreen(path: $path)
                .tabItem {
                    Label("Home", systemImage: "person.3")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            FeaturesScreen(path: $path)
                .tabItem {
                    Label("Features", systemImage: "checkmark.circle")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            ProfileScreen(path: $path)
                .tabItem {
                    Label("Profile", systemImage: "checkmark.circle")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
        }
    }
}

//#Preview {
//    ContentView()
//}
