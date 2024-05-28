//
//  CodeVerificationViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class CodeVerificationViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    func confirmSignUp(username: String, password: String, confirmationCode: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().confirmSignUp(username: username.lowercased(), confirmationCode: confirmationCode) { (signUpResult, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            } else if let _ = signUpResult {
                self.signIn(username: username.lowercased(), password: password, onResult: onResult)
            }
        }
    }
    
    func resendConfirmationCode(username: String, onResult: @escaping (AWSMobileClientResponse<SignUpResult>) -> Void) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().resendSignUpCode(username: username.lowercased()) { (signUpResult, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                onResult(AWSMobileClientResponse<SignUpResult>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            } else if let _ = signUpResult {
                onResult(AWSMobileClientResponse<SignUpResult>(isSuccessful: true, result: nil, exception: nil))
            }
        }
    }
    
    func signIn(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().signIn(username: username.lowercased(), password: password) { (signInResult, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            } else if let signInResult = signInResult {
                
                if signInResult.signInState == .signedIn {
                    AWSMobileClient.default().getTokens() { (tokens, error) in
                        UserRepo.shared.setLoggedIn(token: tokens?.accessToken?.tokenString ?? "")
                    }
                }
                
                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: true, result: signInResult, exception: nil))
            }
        }
    }
}
