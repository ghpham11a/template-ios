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
            
            Spacer()
            
            Divider()
        
            Spacer()
            
            LoadingButton(title: "Submit", isLoading: $viewModel.isLoading, action: {
                viewModel.resetPassword(username: viewModel.username) { response in
                    DispatchQueue.main.async {
                        if response.isSuccessful == true {
                            path.append(String(format: Constants.Route.AUTH_CODE_VERIFICATION, "RESET_PASSWORD", viewModel.username, "IGNORE"))
                        } else {
                            path = NavigationPath()
                            path.append(Constants.Route.SNAG)
                        }
                    }
                }
            })
        }
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHubScreen()
//    }
//}

