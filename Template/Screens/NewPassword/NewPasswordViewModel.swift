//
//  NewPasswordViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import AWSMobileClient
import UIKit

class NewPasswordViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordVerification: String = ""
    @Published var code: String = ""
    
    func confirmPasswordReset(username: String, password: String, passwordVerification: String, code: String, onResult: @escaping (AWSMobileClientResponse<ForgotPasswordResult>) -> Void) {
        
        if password != passwordVerification {
            return
        }
        
        DispatchQueue.main.async { self.isLoading = true }
        
        AWSMobileClient.default().confirmForgotPassword(username: username, newPassword: password, confirmationCode: code) {
            (result, err) in
            if let err = err {
                DispatchQueue.main.async { self.isLoading = false }
                onResult(AWSMobileClientResponse<ForgotPasswordResult>(isSuccessful: false, result: nil, exception: err.localizedDescription))
            } else {
                DispatchQueue.main.async { self.isLoading = false }
                onResult(AWSMobileClientResponse<ForgotPasswordResult>(isSuccessful: true, result: nil, exception: nil))
            }
        }
    }
}
