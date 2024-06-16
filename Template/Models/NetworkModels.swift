//
//  NetworkModels.swift
//  Template
//
//  Created by Anthony Pham on 6/15/24.
//

import Foundation

// Step 1: Define the Error Model
struct APIError: Codable, Error {
    let message: String
    let code: Int
}


// Define the Response Enum
enum APIResponse<T: Codable>: Codable {
    case success(T)
    case failure(APIError)
    
    // Coding Keys for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
    
    // Custom Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .success(let value):
            try container.encode(value, forKey: .success)
        case .failure(let error):
            try container.encode(error, forKey: .failure)
        }
    }
    
    // Custom Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(T.self, forKey: .success) {
            self = .success(value)
            return
        }
        if let error = try? container.decode(APIError.self, forKey: .failure) {
            self = .failure(error)
            return
        }
        throw DecodingError.dataCorruptedError(forKey: .success, in: container, debugDescription: "Data does not match")
    }
}
