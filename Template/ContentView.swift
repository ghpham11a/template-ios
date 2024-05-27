//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        TabView {
            AlphaScreen(path: $path)
                .tabItem {
                    Label("Alpha", systemImage: "person.3")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            BravoScreen(path: $path)
                .tabItem {
                    Label("Bravo", systemImage: "checkmark.circle")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            CharlieScreen(path: $path)
                .tabItem {
                    Label("Charlie", systemImage: "checkmark.circle")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
            DeltaScreen(path: $path)
                .tabItem {
                    Label("Delta", systemImage: "checkmark.circle")
                }
                .toolbar(path.count == 0 ? .visible : .hidden, for: .tabBar)
        }
    }
}

//#Preview {
//    ContentView()
//}
