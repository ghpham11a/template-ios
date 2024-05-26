//
//  ContentView.swift
//  Template
//
//  Created by Anthony Pham on 5/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlphaScreen()
                .tabItem {
                    Label("Alpha", systemImage: "person.3")
                }
            BravoScreen()
                .tabItem {
                    Label("Bravo", systemImage: "checkmark.circle")
                }
            CharlieScreen()
                .tabItem {
                    Label("Charlie", systemImage: "checkmark.circle")
                }
            DeltaScreen()
                .tabItem {
                    Label("Delta", systemImage: "checkmark.circle")
                }
        }
    }
}

//#Preview {
//    ContentView()
//}
