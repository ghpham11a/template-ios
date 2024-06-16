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
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Spacer()
            
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
            
            Spacer()
        }
        .padding()
    }
}

//struct EnterPasswordScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterPasswordScreen()
//    }
//}

