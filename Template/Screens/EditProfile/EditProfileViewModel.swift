//
//  EditProfileViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import UIKit

class EditProfileViewModel: ObservableObject {
    
    func updateImage(image: UIImage?) async -> Bool {
        guard let uiImage = image, let encodedImage = uiImage.toBase64(), let userSub = UserRepo.shared.userSub  else { return false }
        var body = UpdateUserBody()
        body.updateImage = UpdateImage(imageData: encodedImage)
        let response = await APIGatewayService.shared.updateUser(userSub: userSub, body: body)
        
        switch response {
        case .success(let data):
            if data.contains("Image uploaded successfully") == true {
                return true
            } else {
                return false
            }
        case .failure(let error):
            return false
        }
    }
}
