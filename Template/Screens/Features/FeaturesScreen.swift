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
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    TabButton(title: "New", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    .frame(width: 100)
                    .padding(0)

                    TabButton(title: "Old", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    .frame(width: 100)
                    .padding(0)
                    
                    Spacer()
                        .padding(0)
                }
                .padding(0)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.blue)
                    .padding(.horizontal)

                if selectedTab == 0 {
                    NewScreen(path: $path)
                } else if selectedTab == 1 {
                    OldScreen(path: $path)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .stepsGuide:
                    StepsGuideScreen(path: $path)
                default:
                    SnagScreen()
                }
            }
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
                        .frame(height: 3)
                        .foregroundColor(.blue)
                } else {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.clear)
                }
            }
            .padding(0)
            .padding(.horizontal)
            .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

//#Preview {
//    FeaturesScreen()
//}
