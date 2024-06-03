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
        NavigationStack(path: $path) {
            List {
                if (userRepo.isAuthenticated) {
                    
                    MyProfileRow(title: UserRepo.shared.username ?? "", subtitle: "View Profile") {
                        path.append(String(format: Constants.Route.PUBLIC_PROFILE, UserRepo.shared.username ?? ""))
                    }

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
                    
                    HorizontalIconButton(iconName: "star.fill", buttonText: "Button Title", action: {
                        print("Button 1 tapped")
                    })
                } else {
                    Button("Login Bitch") {
                        path.append(Constants.Route.AUTH_HUB)
                    }
                }
            }
            .navigationDestination(for: String.self) { route in
                
                if let parsedRoute = parseRouteParams(from: route) {
                    switch parsedRoute.route {
                    case .authHub:
                        AuthHubScreen(path: $path)
                    case .enterPassword:
                        EnterPasswordScreen(path: $path, username: parsedRoute.params.username, status: parsedRoute.params.status)
                    case .addNewUserInfo:
                        AddNewUserInfoScreen(path: $path, username: parsedRoute.params.username)
                    case .codeVerification:
                        CodeVerificationScreen(path: $path, username: parsedRoute.params.username, password: parsedRoute.params.password)
                    case .snag:
                        SnagScreen()
                    case .public_profile:
                        PublicProfileScreen(path: $path, username: parsedRoute.params.username)
                    case .edit_profile:
                        EditProfileScreen(path: $path)
                    }
                }
            }
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

