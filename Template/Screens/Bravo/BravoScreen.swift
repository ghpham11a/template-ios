//
//  BravoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct BravoScreen: View {
    
    @StateObject private var viewModel = BravoViewModel()
    
    var body: some View {
        NavigationStack {
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
}

//#Preview {
//    BravoScreen()
//}
