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
    
    init(path: Binding<NavigationPath>, username: String) {
        self._path = path
        self.username = username
    }

    var body: some View {
        VStack {
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
                            path.append(String(format: Constants.Route.AUTH_CODE_VERIFICATION, username, viewModel.password))
                        } else {
                            path = NavigationPath([Constants.Route.SNAG])
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

