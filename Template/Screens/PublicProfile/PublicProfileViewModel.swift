//
//  PublicProfileViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import Foundation

class PublicProfileViewModel: ObservableObject {
    
    @Published var isEditable: Bool = false
    
    func checkIfEditable(username: String) {
        DispatchQueue.main.async {
            self.isEditable = UserRepo.shared.username == username
        }
    }
    
}
