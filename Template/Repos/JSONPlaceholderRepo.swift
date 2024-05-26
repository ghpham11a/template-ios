//
//  JSONPlaceholderRepo.swift
//  Template
//
//  Created by Anthony Pham on 5/23/24.
//

import Foundation

class JSONPlaceholderRepo {
    
    static let shared = JSONPlaceholderRepo()
    
    func fetchTodos() async throws -> [Todo]? {
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        return try await NetworkManager.shared.get(urlString: urlString)
    }
    
}
