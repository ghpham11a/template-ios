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
    
    @State private var isEnabledPlacholder: Bool = true
    
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
                    
                    HeadingText(title: "Settings")
                    
                    HorizontalIconButton(name: "ic_payments_hub", buttonText: "Personal information".localized, action: {
                        path.append(Route.personalInfo)
                    })
                    
                    Divider()
                    
                    HorizontalIconButton(name: "ic_payments_hub", buttonText: "Login & security".localized, action: {
                        path.append(Route.loginSecurity)
                    })
                    
                    Divider()
                    
                    HorizontalIconButton(name: "ic_payments_hub", buttonText: "Payments & payouts".localized, action: {
                        path.append(Route.paymentsHub)
                    })
                    
                    Divider()
                    
                    HorizontalIconButton(name: "ic_payments_hub", buttonText: "Availability".localized, action: {
                        path.append(Route.availability)
                    })
                    
                    Divider()
                    
                    LoadingButton(title: "Logout", isLoading: $viewModel.isLoading, isEnabled: $isEnabledPlacholder, action: {
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
                case .paymentsHub:
                    PaymentsHubScreen(path: $path)
                case .paymentMethods:
                    PaymentMethodsScreen(path: $path)
                case .yourPayments:
                    YourPaymentsScreen(path: $path)
                case .payoutMethods:
                    PayoutMethodsScreen(path: $path)
                case .addPayout:
                    AddPayoutScreen(path: $path)
                case .addBankInfo(let country):
                    AddBankInfoScreen(path: $path, country: country)
                case .availability:
                    AvailabilityScreen(path: $path)
                default:
                    SnagScreen()
                }
            }
            .onAppear {
                Task {
                    await readUser()
                }
            }
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.privateReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            break
        case .failure(_):
            break
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

