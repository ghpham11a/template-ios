//
//  BravoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct FeaturesScreen: View {
    
    @StateObject private var viewModel = FeaturesViewModel()
    @State private var selectedTab = 0
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        VStack {
            Text("Features")
            HStack {
                TabButton(title: "New", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }

                TabButton(title: "Old", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
            }
            .background(Color(.systemBackground))
            .padding(.top, 10)
            
            Spacer()

            if selectedTab == 0 {
                NewScreen(path: $path)
            } else if selectedTab == 1 {
                OldScreen(path: $path)
            }

            Spacer()
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.blue)
                } else {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.clear)
                }
            }
            .padding()
            .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

//#Preview {
//    FeaturesScreen()
//}
