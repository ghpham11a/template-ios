//
//  FilterListViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/1/24.
//

import SwiftUI

class FilterListViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var errorMessage: String?
    
    func fetchTodos() {
        Task {
            do {
                let data = try await JSONPlaceholderRepo.shared.fetchTodos()
                DispatchQueue.main.async {
                    self.todos = data ?? []
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
