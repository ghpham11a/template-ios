//
//  ProfileScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/24/24.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = ProfileViewModel()
    @StateObject private var userRepo = UserRepo.shared
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        NavigationStack {
            Text("Delta")
                .navigationTitle("Delta")
            
            if (userRepo.isAuthenticated) {
                LoadingButton(title: "Logout", isLoading: $viewModel.isLoading, action: {
                    viewModel.signOut()
                })
                LoadingButton(title: "Deactivate Account", isLoading: $viewModel.isLoading, action: {
                    Task {
                        let result = await viewModel.disableUser()
                        if result {
                            path = NavigationPath()
                        }
                    }
                })
                LoadingButton(title: "Delete Account", isLoading: $viewModel.isLoading, action: {
                    Task {
                        let result = await viewModel.deleteUser()
                        if result {
                            path = NavigationPath()
                        }
                    }
                })
            }
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

