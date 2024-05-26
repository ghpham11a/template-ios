//
//  NetworkManager.swift
//  Template
//
//  Created by Anthony Pham on 5/23/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
