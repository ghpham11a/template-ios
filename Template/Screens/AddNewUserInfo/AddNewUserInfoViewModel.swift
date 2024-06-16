//
//  AddNewUserInfoViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class AddNewUserInfoViewModel: ObservableObject {
    
    @Published var firstName: String = "Anthony"
    @Published var lastName: String = "Pham"
    @Published var dateOfBirth: String = "1988-10-11"
    @Published var phoneNumber: String = ""
    @Published var username: String = ""
    @Published var password: String = "ABcd1234$$"
    @Published var isLoading: Bool = false
    
    func signUp(username: String, password: String, onResult: @escaping (AWSMobileClientResponse<SignUpResult>) -> Void) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let formattedUsername = username.lowercased()
        var userAttributes = [
            "birthdate": dateOfBirth,
            "email": formattedUsername,
            "given_name": firstName,
            "family_name": lastName
        ]
        
        if phoneNumber != "" {
            userAttributes["phone_number"] = phoneNumber
        }
        
        AWSMobileClient.default().signUp(username: formattedUsername, password: password, userAttributes: userAttributes) { (signUpResult, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                onResult(AWSMobileClientResponse<SignUpResult>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            } else if let signUpResult = signUpResult {
                onResult(AWSMobileClientResponse<SignUpResult>(isSuccessful: true, result: signUpResult, exception: nil))
            }
        }
    }
}
