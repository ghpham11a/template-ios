//
//  DeltaViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    func signOut() {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().signOut()
        UserRepo.shared.logOut()
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
