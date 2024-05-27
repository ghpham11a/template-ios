//
//  AuthHubViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import Foundation

class AuthHubViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var isLoading: Bool = false
    
    func checkIfUserExists() async -> Bool {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let users = Set(["gm.pham@gmail.com"])
        
        do {
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        } catch {
            
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        return users.contains(username.lowercased())
    }
}
