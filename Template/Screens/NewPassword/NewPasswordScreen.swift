//
//  NewPasswordScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import SwiftUI

struct NewPasswordScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = NewPasswordViewModel()
    @State private var username: String
    @State private var code: String
    
    init(path: Binding<NavigationPath>, username: String, code: String) {
        self._path = path
        self.username = username
        self.code = code
    }

    var body: some View {
        VStack {
            Text("Create new password")
                .padding(.bottom, 40)
            
            TextField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Spacer()
            
            TextField("Confirm password", text: $viewModel.passwordVerification)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Divider()
        
            Spacer()
            
            LoadingButton(title: "Submit", isLoading: $viewModel.isLoading, action: {
                
                viewModel.confirmPasswordReset(username: username, password: viewModel.password, passwordVerification: viewModel.passwordVerification, code: code) { response in
                    if response.isSuccessful == true {
                        path = NavigationPath()
                        path.append(Route.resetPasswordSuccess)
                    } else {
                        path = NavigationPath()
                        path.append(Route.snag)
                    }
                }
            })
        }
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPasswordScreen()
//    }
//}
