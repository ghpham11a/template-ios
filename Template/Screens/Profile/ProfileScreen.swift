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
            ScrollView {
                if (userRepo.isAuthenticated) {
                    
                    MyProfileRow(title: UserRepo.shared.username ?? "", subtitle: "View Profile") {
                        path.append(String(format: Constants.Route.PUBLIC_PROFILE, UserRepo.shared.username ?? ""))
                    }
                    
                    Spacer()
                    
                    HorizontalIconButton(iconName: "star.fill", buttonText: "Button Title", action: {
                        path.append(Constants.Route.LOGIN_SECURITY)
                    })
                    
                    LoadingButton(title: "Logout", isLoading: $viewModel.isLoading, action: {
                        viewModel.signOut()
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
                        CodeVerificationScreen(path: $path, verificationType: parsedRoute.params.verificationType, username: parsedRoute.params.username, password: parsedRoute.params.password)
                    case .snag:
                        SnagScreen()
                    case .public_profile:
                        PublicProfileScreen(path: $path, username: parsedRoute.params.username)
                    case .edit_profile:
                        EditProfileScreen(path: $path)
                    case .reset_password:
                        ResetPasswordScreen(path: $path)
                    case .newPassword:
                        NewPasswordScreen(path: $path, username: parsedRoute.params.username, code: parsedRoute.params.code)
                    case .resetPasswordSuccess:
                        PasswordResetSucesssScreen(path: $path)
                    case .login_and_security:
                        LoginAndSecurityScreen(path: $path)
                    default:
                        SnagScreen()
                    }
                }
            }
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

