//
//  DeltaViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class DeltaViewModel: ObservableObject {
    
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
    
    func disableUser() async -> Bool {
        DispatchQueue.main.async { self.isLoading = true }
        do {
            let username = UserRepo.shared.username ?? ""
            let body = ["status": "disable", "username": username]
            let data: String? = try await APIGatewayService.shared.adminUpdateUser(username: username, body: body)
            
            DispatchQueue.main.async { self.isLoading = false }
            
            if data?.contains("disabled successfully") == true {
                UserRepo.shared.logOut()
                return true
            } else {
                return false
            }
        } catch {
            DispatchQueue.main.async { self.isLoading = false }
            return false
        }
    }
    
    func deleteUser() async -> Bool {
        DispatchQueue.main.async { self.isLoading = true }
        do {
            let username = UserRepo.shared.username ?? ""
            let data: String? = try await APIGatewayService.shared.adminDeleteUser(username: username)
            
            DispatchQueue.main.async { self.isLoading = false }
            
            if data?.contains("deleted successfully") == true {
                UserRepo.shared.logOut()
                return true
            } else {
                return false
            }
        } catch {
            DispatchQueue.main.async { self.isLoading = false }
            return false
        }
    }
}
