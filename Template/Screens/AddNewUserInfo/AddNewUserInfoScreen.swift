//
//  AddNewUserInfoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct AddNewUserInfoScreen: View {
    
    @Binding var path: NavigationPath
    var username: String = ""
    var phoneNumber: String = ""
    
    @StateObject private var viewModel = AddNewUserInfoViewModel()

    var body: some View {
        ScrollView {
            
            TextField("First name on ID", text: $viewModel.firstName)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Spacer()
            
            TextField("Last name on ID", text: $viewModel.lastName)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Spacer()
            
            TextField("Email", text: $viewModel.username)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .disabled(username != "")
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
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
        .onAppear {
            viewModel.username = username
            viewModel.phoneNumber = phoneNumber
        }
        .padding()
    }
}

//struct AddNewUserInfoScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewUserInfoScreen()
//    }
//}
