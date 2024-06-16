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
    @Published var isDisabling: Bool = false
    @Published var isDeleting: Bool = false

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
        DispatchQueue.main.async { self.isDisabling = true }
        
        let username = UserRepo.shared.username ?? ""
        let body = ["status": "disable", "username": username]
        let response = await APIGatewayService.shared.adminUpdateUser(username: username, body: body)
        
        DispatchQueue.main.async { self.isDisabling = false }
        
        switch response {
        case .success(let data):
            if data.contains("disabled successfully") == true {
                UserRepo.shared.logOut()
                return true
            } else {
                return false
            }
        case .failure(let error):
            return false
        }
    }
    
    func deleteUser() async -> Bool {
        DispatchQueue.main.async { self.isDeleting = true }
        
        let username = UserRepo.shared.username ?? ""
        let response = await APIGatewayService.shared.adminDeleteUser(username: username)
        
        DispatchQueue.main.async { self.isDeleting = false }
        
        switch response {
        case .success(let data):
            if data.contains("deleted successfully") == true {
                UserRepo.shared.logOut()
                return true
            } else {
                return false
            }
        case .failure(let error):
            return false
        }
    }
}
