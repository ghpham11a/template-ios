//
//  TabbedListScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/8/24.
//

import SwiftUI

struct TabbedListScreen: View {
    
    @Binding var path: NavigationPath
    
    @StateObject private var viewModel = FeaturesViewModel()
    @State private var selectedTab = 0
    @StateObject private var userRepo = UserRepo.shared

    var body: some View {
        VStack(spacing: 0) {
            
            if userRepo.isAuthenticated {
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
                    .frame(alignment: .leading)
                } else if selectedTab == 1 {
                    List {
                        ForEach(viewModel.oldItems, id: \.title) { feature in
                            FeaturesCard(title: feature.title, description: feature.description) {
                                path.append(feature.route)
                            }
                        }
                    }
                    .frame(alignment: .leading)
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
