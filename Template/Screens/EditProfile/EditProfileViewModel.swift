//
//  EditProfileViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import UIKit

class EditProfileViewModel: ObservableObject {
    
    func updateImage(image: UIImage?) async -> Bool {
        guard let uiImage = image else { return false }
        do {
            let userSub = UserRepo.shared.userSub ?? ""
            let body = ["updateImage": ["imageData": uiImage.toBase64()]]
            let data: String? = try await APIGatewayService.shared.updateUser(userSub: userSub, body: body)
            
            if data?.contains("Image uploaded successfully") == true {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
