//
//  AuthHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import SwiftUI


struct AuthHubScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = AuthHubViewModel()
    @State private var isPhoneNumberMode: Bool = false
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        VStack {
            Text("Login or sign up")
            
            if !isPhoneNumberMode {
                
                OutlinedTextField(title: "Email", placeholder: "", text: $viewModel.username)
                
                LoadingButton(title: "Continue", isLoading: $viewModel.isLoading, action: {
                    Task {
                        let result = await viewModel.checkIfUserExists(username: viewModel.username)
                        if result.isSuccessful {
                            switch result.userStatus {
                            case .existsAndEnabled:
                                path.append(Route.authEnterPassword(username: viewModel.username, status: "enabled"))
                            case .existsAndDisabled:
                                path.append(Route.authEnterPassword(username: viewModel.username, status: "disabled"))
                            case .doesNotExist:
                                path.append(Route.authAddInfo(username: viewModel.username))
                            }
                        } else {
                            path = NavigationPath([Route.snag])
                        }
                    }
                })
                
                HStack {
                    Text("Forgot your password? ")
                        .padding(0)
                    Text("Reset it.")
                        .padding(0)
                        .offset(CGSize(width: -5, height: 0))
                        .onTapGesture {
                            path.append(Route.resetPassword)
                        }
                }
                .frame(alignment: .center)
                
            } else {
                
                PhoneNumberField(selectedCountryCode: $viewModel.selectedCountryCode, phoneNumber: $viewModel.phoneNumber)
                
                Button(action: {
                    Task {
                        
                        let code = viewModel.selectedCountryCode.filter { $0.isNumber }
                        let formattedPhoneNumber = "+\(code)\(viewModel.phoneNumber.filter{ $0.isNumber })"
                        let result = await viewModel.checkIfUserExists(phoneNumber: formattedPhoneNumber)
//                        if result.isSuccessful {
//                            switch result.userStatus {
//                            case .existsAndEnabled:
//                                path.append(Route.authEnterPassword(username: viewModel.username, status: "enabled"))
//                            case .existsAndDisabled:
//                                path.append(Route.authEnterPassword(username: viewModel.username, status: "disabled"))
//                            case .doesNotExist:
//                                path.append(Route.authAddInfo(username: viewModel.username))
//                            }
//                        } else {
//                            path = NavigationPath([Route.snag])
//                        }
                    }
                    
                    
                    
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            Divider()
            
            if isPhoneNumberMode {
                OutlinedButton(
                    text: "Continue with Email",
                    iconName: "star",
                    action: {
                        isPhoneNumberMode = !isPhoneNumberMode
                    }
                )
            } else {
                OutlinedButton(
                    text: "Continue with Phone",
                    iconName: "star",
                    action: {
                        isPhoneNumberMode = !isPhoneNumberMode
                    }
                )
            }
            
            Spacer()
        }
        .frame(alignment: .top)
        .padding(.horizontal)
    }
    
    private var attributedString: AttributedString {
        var attributedString = AttributedString("Forgot your password? Reset it.")
        
        if let range = attributedString.range(of: "Reset it") {
            attributedString[range].foregroundColor = .blue
            attributedString[range].underlineStyle = .single
        }
        
        return attributedString
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHubScreen()
//    }
//}
