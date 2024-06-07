//
//  AddNewUserInfoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct AddNewUserInfoScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = AddNewUserInfoViewModel()
    @State private var username: String
    
    init(path: Binding<NavigationPath>, username: String) {
        self._path = path
        self.username = username
    }

    var body: some View {
        VStack {
            Text("Sign up as \(username)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(action: {
                viewModel.signUp(username: username, password: viewModel.password) { response in
                    if response.isSuccessful == true {
                        path.append(Route.authCodeVerification(verificationType: "SIGN_UP", username: username, password: viewModel.password))
                    } else {
                        path = NavigationPath([Route.snag])
                    }
                }
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
            .padding(.top, 20)
            
            Spacer()
        }
    }
}

//struct AddNewUserInfoScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewUserInfoScreen()
//    }
//}
