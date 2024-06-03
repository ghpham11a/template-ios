//
//  UpdateUserBody.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import Foundation

struct UpdateUserBody: Codable {
    let updateImage: UpdateImage?

    enum CodingKeys: String, CodingKey {
        case updateImage = "updateImage"
    }
}

struct UpdateImage: Codable {
    let imageData: String

    enum CodingKeys: String, CodingKey {
        case imageData = "imageData"
    }
}
