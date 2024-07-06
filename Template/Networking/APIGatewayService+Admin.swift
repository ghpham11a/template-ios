//
//  APIGatewayService+Admin.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import Foundation

extension APIGatewayService {
    
    func adminReadUser(username: String, phoneNumber: String) async -> APIResponse<AdminReadUserResponse> {
        
        if username == "" && phoneNumber == "" {
            return .failure(APIError(message: "", code: 0))
        }
        
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        var queryParams: [String: String] = [:]
        if username != "" {
            queryParams["username"] = encodedUsername
        }
        if phoneNumber != "" {
            queryParams["phoneNumber"] = phoneNumber
        }
        
        let url = "\(baseURL)/admin/users"
        let headers = NetworkManager.shared.buildHeaders()
        do {
            let data: AdminReadUserResponse = try await NetworkManager.shared.get(urlString: url, queryParams: queryParams, headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
       
    }
    
    func adminDisableUser(username: String) async -> APIResponse<AdminDisableUserResponse> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)/disable"
        do {
            let data: AdminDisableUserResponse = try await NetworkManager.shared.patch(urlString: url, headers: NetworkManager.shared.buildHeaders(), body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func adminEnableUser(username: String) async -> APIResponse<AdminEnableUserResponse> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)/enable"
        do {
            let data: AdminEnableUserResponse = try await NetworkManager.shared.patch(urlString: url, headers: NetworkManager.shared.buildHeaders(), body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func adminUpdateUser(username: String, body: [String: Any]) async -> APIResponse<AdminDeleteUserResponse> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: AdminDeleteUserResponse = try await NetworkManager.shared.put(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func adminDeleteUser(username: String) async -> APIResponse<String> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: String = try await NetworkManager.shared.delete(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
