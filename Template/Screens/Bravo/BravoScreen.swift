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
                    if route == Constants.Route.AUTH_HUB {
                        AuthHubScreen(path: $path)
                    }
                    if route == Constants.Route.AUTH_ENTER_PASSWORD {
                        EnterPasswordScreen(path: $path)
                    }
                    if route == Constants.Route.AUTH_ADD_INFO {
                        AddNewUserInfoScreen(path: $path)
                    }
                }
            }
            
        }
    }
}

//#Preview {
//    BravoScreen()
//}
