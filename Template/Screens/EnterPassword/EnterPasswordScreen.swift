//
//  EnterPasswordScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct EnterPasswordScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = EnterPasswordViewModel()
    @State private var username: String
    @State private var status: String
    
    init(path: Binding<NavigationPath>, username: String, status: String) {
        self._path = path
        self.username = username
        self.status = status
    }

    var body: some View {
        VStack {
            
            if status == "disabled" {
                Text("Welcome back")
                    .font(.headline)
                    .padding(.bottom, 40)
            }
            
            Text("Enter password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            LoadingButton(title: "Sign in", isLoading: $viewModel.isLoading, action: {
                viewModel.signIn(username: username, password: viewModel.password) { response in
                    if response.isSuccessful == true {
                        path = NavigationPath()
                    } else {
                        if response.exception?.contains("userNotConfirmed") == true {
                            path.append(Route.authCodeVerification(verificationType: "SIGN_UP", username: username, password: viewModel.password))
                        } else {
                            path = NavigationPath([Route.snag])
                        }
                    }
                }
            })
        }
    }
}

//struct EnterPasswordScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterPasswordScreen()
//    }
//}

