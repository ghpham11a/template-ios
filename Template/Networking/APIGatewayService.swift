//
//  APIGatewayService.swift
//  Template
//
//  Created by Anthony Pham on 5/30/24.
//

import Foundation

class APIGatewayService {
    
    static let shared = APIGatewayService()
    
    private let baseURL = "https://o7hniu19pc.execute-api.us-east-1.amazonaws.com/qa"
    
    func adminGetUser(username: String) async throws -> CheckIfUserExistsResponse? {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildHeaders()
        return try await NetworkManager.shared.get(urlString: url, headers: headers)
    }
    
    func adminEnableUser(username: String, body: [String: Any]) async throws -> String? {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)/enable"
        let headers = NetworkManager.shared.buildHeaders()
        return try await NetworkManager.shared.put(urlString: url, headers: NetworkManager.shared.buildHeaders(), body: body)
    }
    
    func adminUpdateUser(username: String, body: [String: Any]) async throws -> String? {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        return try await NetworkManager.shared.put(urlString: url, headers: headers, body: body)
    }
    
    func adminDeleteUser(username: String) async throws -> String? {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        return try await NetworkManager.shared.delete(urlString: url, headers: headers)
    }
    
    func updateUser(userSub: String, body: [String: Any]) async throws -> String? {
        let url = "\(baseURL)/users/\(userSub)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        return try await NetworkManager.shared.patch(urlString: url, headers: headers, body: body)
    }
}
