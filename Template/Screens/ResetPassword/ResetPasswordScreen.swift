//
//  ResetPasswordViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import SwiftUI

struct ResetPasswordScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = ResetPasswordViewModel()
    
    @State private var isEnabledPlaceholder: Bool = true
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        VStack {
            Text("Reset Password")
                .padding(.bottom, 40)
            
            TextField("Email", text: $viewModel.username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Divider()
            
            LoadingButton(title: "Submit", isLoading: $viewModel.isLoading, isEnabled: $isEnabledPlaceholder, action: {
                viewModel.resetPassword(username: viewModel.username) { response in
                    DispatchQueue.main.async {
                        if response.isSuccessful == true {
                            path.append(Route.authCodeVerification(verificationType: "RESET_PASSWORD", username: viewModel.username, password: "IGNORE"))
                        } else {
                            path = NavigationPath()
                            path.append(Route.snag)
                        }
                    }
                }
            })
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHubScreen()
//    }
//}

