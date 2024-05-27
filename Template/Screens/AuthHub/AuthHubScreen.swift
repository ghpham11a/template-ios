//
//  AuthHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import SwiftUI

struct AuthHubScreen: View {
    
    @StateObject private var viewModel = AuthHubViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Login or sign up")
                    .padding(.bottom, 40)
                
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Spacer()
                
                Divider()
            
                Spacer()
                
                LoadingButton(title: "Continue", isLoading: $viewModel.isLoading, action: {
                    Task {
                        let result = await viewModel.checkIfUserExists()
                        if result {
                        
                        } else {
                            
                        }
                    }
                })
            }
        }
        .navigationBarTitle("Auth Screen", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(icon: .remove))
        .onAppear {
            Router.shared.push(url: Constants.Route.AUTH_HUB)
        }
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHubScreen()
//    }
//}
