//
//  FilterListScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/1/24.
//

import SwiftUI

struct FilterListScreen: View {
    
    @StateObject private var viewModel = FeaturesViewModel()
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
                .navigationDestination(for: Route.self) { route in
//                    if let parsedRoute = parseRouteParams(from: route) {
//                        switch parsedRoute.route {
//                        case .authHub:
//                            AuthHubScreen(path: $path)
//                        case .enterPassword:
//                            EnterPasswordScreen(path: $path, username: parsedRoute.params.username, status: parsedRoute.params.status)
//                        case .addNewUserInfo:
//                            AddNewUserInfoScreen(path: $path, username: parsedRoute.params.username)
//                        case .codeVerification:
//                            CodeVerificationScreen(path: $path, verificationType: parsedRoute.params.verificationType, username: parsedRoute.params.username, password: parsedRoute.params.password)
//                        case .snag:
//                            SnagScreen()
//                        default:
//                            SnagScreen()
//                        }
//                    }
                }
            }
            
        }
    }
}

//#Preview {
//    FilterListScreen()
//}
