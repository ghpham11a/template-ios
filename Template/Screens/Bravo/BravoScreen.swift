//
//  BravoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct BravoScreen: View {
    
    @StateObject private var viewModel = BravoViewModel()
    @StateObject private var userRepo = UserRepo.shared
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            if (userRepo.isAuthenticated) {
                List {
                    ForEach(viewModel.todos, id: \.id) { todo in
                        Text(todo.title ?? "NULL")
                    }
                }
                .onAppear {
                    viewModel.fetchTodos()
                }
            } else {
                Button("Login Bitch") {
                    path.append(Constants.Route.AUTH_HUB)
                }
                .navigationDestination(for: String.self) { route in
                    let params = parseRouteParams(from: route)
                    if route.contains(Constants.Route.AUTH_HUB_ROOT) {
                        AuthHubScreen(path: $path)
                    }
                    if route.contains(Constants.Route.AUTH_ENTER_PASSWORD_ROOT), let username = params["username"] {
                        EnterPasswordScreen(path: $path, username: username)
                    }
                    if route.contains(Constants.Route.AUTH_ADD_INFO_ROOT), let username = params["username"] {
                        AddNewUserInfoScreen(path: $path, username: username)
                    }
                    if route.contains(Constants.Route.AUTH_CODE_VERIFICATION_ROOT), let username = params["username"], let password = params["password"] {
                        CodeVerificationScreen(path: $path, username: username, password: password)
                    }
                    if route.contains(Constants.Route.SNAG) {
                        SnagScreen()
                    }
                }
            }
            
        }
    }
}

//#Preview {
//    BravoScreen()
//}
