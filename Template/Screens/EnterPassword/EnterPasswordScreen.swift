//
//  EnterPasswordScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct EnterPasswordScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                if showPassword {
                    TextField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                } else {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Text(showPassword ? "Hide Password" : "Show Password")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    // Handle login action
                    print("Username: \(username), Password: \(password)")
                }) {
                    Text("Login")
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
            .padding(.horizontal, 40)
        }
        .navigationBarTitle("Auth Screen", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(icon: .remove))
        .onAppear {
            Router.shared.push(url: Constants.Route.AUTH_HUB)
        }
    }
}

//struct EnterPasswordScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterPasswordScreen()
//    }
//}

