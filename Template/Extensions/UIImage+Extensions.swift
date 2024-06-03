//
//  UIImage+Extensions.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}
