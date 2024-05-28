//
//  DeltaViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import AWSMobileClient
import Foundation

class DeltaViewModel: ObservableObject {
    
    func signOut() {
        AWSMobileClient.default().signOut()
        UserRepo.shared.logOut()
    }
}
