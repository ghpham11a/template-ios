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
    
    func checkIfUserExists() async -> (isSuccessful: Bool, userStatus: UserStatus) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let result = await UserRepo.shared.checkUserStatus(username: username.lowercased())
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        return (true, result)
    }
}
