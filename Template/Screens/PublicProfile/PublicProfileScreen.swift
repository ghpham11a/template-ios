//
//  PublicProfileScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import SwiftUI

struct PublicProfileScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = PublicProfileViewModel()
    @State private var username: String
    @StateObject private var userRepo = UserRepo.shared

    init(path: Binding<NavigationPath>, username: String) {
        self._path = path
        self.username = username
    }
    
    var body: some View {
        List {
            if viewModel.isEditable {
                
                AsyncImage(url: URL(string: String(format: Constants.USER_IMAGE_URL, UserRepo.shared.userSub ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        EmptyView()
                    }
                }
                .id(userRepo.imageRefreshId)
                .clipShape(.circle)
                .frame(width: 100, height: 100)
                .listRowBackground(Color.clear)
                
                Button("Edit") {
                    path.append(String(format: Constants.Route.EDIT_PROFILE))
                }
                .listRowBackground(Color.clear)
            }
        }
        .onAppear {
            viewModel.checkIfEditable(username: username)
        }
    }
}
