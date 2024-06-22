//
//  EnterPasswordViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class EnterPasswordViewModel: ObservableObject {
    
    @Published var password: String = "ABcd1234$$"
    @Published var isLoading: Bool = false
    
    private func enableUser(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        DispatchQueue.main.async { self.isLoading = true }
        Task {
            let response = await APIGatewayService.shared.adminEnableUser(username: username)
            
            DispatchQueue.main.async { self.isLoading = false }
            switch response {
            case .success(let data):
                if data.message?.contains("enabled successfully") == true {
                    signIn(username: username, password: password, onResult: onResult)
                } else {
                    onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: nil))
                }
            case .failure(let error):
                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            }
        }
    }
    
    func signIn(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        
        DispatchQueue.main.async { self.isLoading = true }
        
        let formattedUsername = username.lowercased()
        
        AWSMobileClient.default().signIn(username: formattedUsername, password: password) { (signInResult, error) in
            
            DispatchQueue.main.async { self.isLoading = false }
            
            if let error = error {
                let errorResult = AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: String(describing: error))
                if case .notAuthorized(let message) = error as? AWSMobileClientError {
                    if message.contains("User is disabled") == true {
                        self.enableUser(username: username, password: password, onResult: onResult)
                    } else {
                        DispatchQueue.main.async { self.isLoading = false }
                        onResult(errorResult)
                    }
                } else {
                    DispatchQueue.main.async { self.isLoading = false }
                    onResult(errorResult)
                }
                
            } else if let signInResult = signInResult {
                
                DispatchQueue.main.async { self.isLoading = false }
                
                AWSMobileClient.default().getUserAttributes { (userAttributes, error) in
                    
                }
            
                if signInResult.signInState == .signedIn {
                    AWSMobileClient.default().getTokens() { (tokens, error) in
                        if let tokens = tokens {
                            AWSMobileClient.default().getUserAttributes { (userAttributes, error) in
                                UserRepo.shared.setLoggedIn(tokens: tokens, username: formattedUsername, userAttributes: userAttributes ?? [:])
                                onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: true, result: signInResult, exception: nil))
                            }
                        } else {
                            onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: nil))
                        }
                    }
                } else {
                    onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: nil))
                }
            }
        }
    }
}
