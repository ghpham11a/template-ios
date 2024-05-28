//
//  EnterPasswordViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class EnterPasswordViewModel: ObservableObject {
    
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    func signIn(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().signIn(username: username.lowercased(), password: password) { (signInResult, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: nil))
            
            
//            if let error = error {
//                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: String(describing: error)))
//            } else if let signInResult = signInResult {
//            
//            
//                if signInResult.signInState == .signedIn {
//                    AWSMobileClient.default().getTokens() { (tokens, error) in
//                        UserRepo.shared.setLoggedIn(token: tokens?.accessToken?.tokenString ?? "")
//                    }
//                }
//                
//                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: true, result: signInResult, exception: nil))
//        
//            }
        }
    }
}
