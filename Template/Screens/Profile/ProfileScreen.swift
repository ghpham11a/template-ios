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
                        path.append(Route.publicProfile(username: UserRepo.shared.username ?? ""))
                    }
                    
                    Spacer()
                    
                    Text("Settings")
                    
                    HorizontalIconButton(iconName: "star.fill", buttonText: "Personal information", action: {
                        path.append(Route.personalInfo)
                    })
                    
                    HorizontalIconButton(iconName: "star.fill", buttonText: "Login and security", action: {
                        path.append(Route.loginSecurity)
                    })
                    
                    LoadingButton(title: "Logout", isLoading: $viewModel.isLoading, action: {
                        viewModel.signOut()
                    })
                    
                } else {
                    Button("Login Bitch") {
                        path.append(Route.auth)
                    }
                }
            }
            .padding()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .auth:
                    AuthHubScreen(path: $path)
                case .authEnterPassword(let username, let status):
                    EnterPasswordScreen(path: $path, username: username, status: status)
                case .authAddInfo(let username):
                    AddNewUserInfoScreen(path: $path, username: username)
                case .authCodeVerification(let verificationType, let username, let password):
                    CodeVerificationScreen(path: $path, verificationType: verificationType, username: username, password: password)
                case .snag:
                    SnagScreen()
                case .publicProfile(let username):
                    PublicProfileScreen(path: $path, username: username)
                case .editProfile:
                    EditProfileScreen(path: $path)
                case .resetPassword:
                    ResetPasswordScreen(path: $path)
                case .newPassword(let username, let code):
                    NewPasswordScreen(path: $path, username: username, code: code)
                case .resetPasswordSuccess:
                    PasswordResetSucesssScreen(path: $path)
                case .loginSecurity:
                    LoginAndSecurityScreen(path: $path)
                case .personalInfo:
                    PersonalInfoScreen(path: $path)
                default:
                    SnagScreen()
                }
            }
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

