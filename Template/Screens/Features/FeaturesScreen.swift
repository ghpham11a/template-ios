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
                    List {
                        ForEach(viewModel.newItems, id: \.title) { feature in
                            FeaturesCard(title: feature.title, description: feature.description) {
                                path.append(feature.route)
                            }
                        }
                    }
                } else if selectedTab == 1 {
                    List {
                        ForEach(viewModel.oldItems, id: \.title) { feature in
                            FeaturesCard(title: feature.title, description: feature.description) {
                                path.append(feature.route)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .thing:
                    ThingScreen(path: $path)
                case .thingBuilder(let mode, let steps):
                    ThingBuilderScreen(path: $path, mode: mode, steps: steps, action: {
                        path.removeLast()
                    })
                case .filterList:
                    FilterListScreen(path: $path)
                default:
                    SnagScreen()
                }
            }
            .onAppear {
                viewModel.fetchItems()
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
