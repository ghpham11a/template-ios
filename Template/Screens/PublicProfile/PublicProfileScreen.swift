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
    
    @State private var schoolName: String = ""
    
    @State private var isScreenLoading: Bool = true

    init(path: Binding<NavigationPath>, username: String) {
        self._path = path
        self.username = username
    }
    
    var body: some View {
        
        if isScreenLoading {
            LoadingScreen()
                .onAppear {
                    viewModel.checkIfEditable(username: username)
                    Task {
                        await readUser()
                    }
                }
        } else {
            ScrollView {
                AsyncImage(url: URL(string: String(format: Constants.USER_IMAGE_URL, UserRepo.shared.userId ?? ""))) { phase in
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
                
                HorizontalIconButton(iconName: "star.fill", buttonText: "Where I went to school \(schoolName != "" ? ": \(schoolName)" : "")", action: {}, isLabelOnly: true)
            }
            .navigationBarItems(trailing: viewModel.isEditable ? Button(action: {
                path.append(Route.editProfile)
            }) {
                Text("Edit")
            } : nil)
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.publicReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            schoolName = data.schoolName ?? ""
            isScreenLoading = false
        case .failure(let error):
            isScreenLoading = false
            break
        }
    }
}
