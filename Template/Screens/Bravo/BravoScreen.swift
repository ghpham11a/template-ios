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
    
    var body: some View {
        NavigationStack {
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
                NavigationLink(destination: AuthScreen()) {
                    Text("Login")
                        .padding()
                }
            }
            
        }
        .onAppear {
            Router.shared.replace(url: "alpha")
        }
    }
}

//#Preview {
//    BravoScreen()
//}
