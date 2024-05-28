//
//  AuthHubViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class AuthHubViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var isLoading: Bool = false
    
    func checkIfUserExists() async -> (isSuccessful: Bool, doesUserExist: Bool) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let users = Set(["gm.pham@gmail.com", "anthony.b.pham@outlook.com"])
        
        do {
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        } catch {
            
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        return (true, users.contains(username.lowercased()))
    }
}
