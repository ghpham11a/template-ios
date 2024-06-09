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
        List {
            ForEach(viewModel.todos, id: \.id) { todo in
                Text(todo.title ?? "NULL")
            }
        }
        .onAppear {
            viewModel.fetchTodos()
        }
    }
}

//#Preview {
//    FilterListScreen()
//}
