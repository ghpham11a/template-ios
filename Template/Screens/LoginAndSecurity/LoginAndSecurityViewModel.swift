//
//  LoginAndSecurityViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import AWSMobileClient
import UIKit

class LoginAndSecurityViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false

    @Published var username: String = ""
    
    func changePassword(currentPassword: String, proposedPassword: String, onResult: @escaping (AWSMobileClientResponse<String>) -> Void) {
        
        DispatchQueue.main.async { self.isLoading = true }
        
        AWSMobileClient.default().changePassword(currentPassword: currentPassword, proposedPassword: proposedPassword) { err in
            if let err = err {
                DispatchQueue.main.async { self.isLoading = false }
                onResult(AWSMobileClientResponse(isSuccessful: false, result: nil, exception: nil))
            } else {
                DispatchQueue.main.async { self.isLoading = false }
                onResult(AWSMobileClientResponse(isSuccessful: true, result: nil, exception: nil))
            }
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
