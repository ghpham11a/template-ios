//
//  AuthHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import SwiftUI

struct AuthHubScreen: View {
    
    @Binding private var path: NavigationPath
    
    @StateObject private var viewModel = AuthHubViewModel()
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
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
                        path.append(Constants.Route.AUTH_ENTER_PASSWORD)
                    } else {
                        path.append(Constants.Route.AUTH_ADD_INFO)
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
