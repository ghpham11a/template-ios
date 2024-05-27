//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var router = Router.shared
    
    var body: some View {
        
        return TabView {
            AlphaScreen()
                .tabItem {
                    Label("Alpha", systemImage: "person.3")
                }
                .toolbar(router.isToolBarVisible, for: .tabBar)
            BravoScreen()
                .tabItem {
                    Label("Bravo", systemImage: "checkmark.circle")
                }
                .toolbar(router.isToolBarVisible, for: .tabBar)
            CharlieScreen()
                .tabItem {
                    Label("Charlie", systemImage: "checkmark.circle")
                }
                .toolbar(router.isToolBarVisible, for: .tabBar)
            DeltaScreen()
                .tabItem {
                    Label("Delta", systemImage: "checkmark.circle")
                }
                .toolbar(router.isToolBarVisible, for: .tabBar)
        }
    }
}

//#Preview {
//    ContentView()
//}
