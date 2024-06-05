//
//  ResetPasswordScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import AWSMobileClient
import UIKit

class ResetPasswordViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var username: String = ""
    
    func resetPassword(username: String, onResult: @escaping (AWSMobileClientResponse<ForgotPasswordResult>) -> Void) {
        
        DispatchQueue.main.async { self.isLoading = true }
        
        AWSMobileClient.default().forgotPassword(username: username.lowercased()) { (result, err) in
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
