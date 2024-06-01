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
    
    private func enableUser(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignInResult>) -> Void) {
        DispatchQueue.main.async { self.isLoading = true }
        Task {
            do {
                let body = ["status": "enable", "username": username]
                let data: String? = try await APIGatewayService.shared.adminEnableUser(username: username, body: body)
                
                DispatchQueue.main.async { self.isLoading = false }
                
                if data?.contains("enabled successfully") == true {
                    signIn(username: username, password: password, onResult: onResult)
                } else {
                    onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: false, result: nil, exception: nil))
                }
            } catch {
                DispatchQueue.main.async { self.isLoading = false }
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
            
                if signInResult.signInState == .signedIn {
                    AWSMobileClient.default().getTokens() { (tokens, error) in
                        if let tokens = tokens {
                            UserRepo.shared.setLoggedIn(tokens: tokens, username: formattedUsername)
                            onResult(AWSMobileClientResponse<SignInResult>(isSuccessful: true, result: signInResult, exception: nil))
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
