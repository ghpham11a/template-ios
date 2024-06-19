//
//  APIGatewayService.swift
//  Template
//
//  Created by Anthony Pham on 5/30/24.
//

import Foundation

class APIGatewayService {
    
    static let shared = APIGatewayService()
    
    private let baseURL = "https://gviivl9o82.execute-api.us-east-1.amazonaws.com/qa"
    
    func adminReadtUser(username: String, phoneNumber: String) async -> APIResponse<AdminReadUserResponse> {
        
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
    
    func adminEnableUser(username: String, body: [String: Any]) async -> APIResponse<String> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)/enable"
        do {
            let data: String = try await NetworkManager.shared.put(urlString: url, headers: NetworkManager.shared.buildHeaders(), body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func adminUpdateUser(username: String, body: [String: Any]) async -> APIResponse<String> {
        let encodedUsername: String = username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = "\(baseURL)/admin/users/\(encodedUsername)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: String = try await NetworkManager.shared.put(urlString: url, headers: headers, body: body)
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
            let data: String = try await NetworkManager.shared.delete(urlString: url, headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func privateReadUser(userSub: String) async -> APIResponse<ReadUserPrivateResponse> {
        let url = "\(baseURL)/private/users/\(userSub)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadUserPrivateResponse = try await NetworkManager.shared.get(urlString: url, headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func publicReadUser(userSub: String) async -> APIResponse<ReadUserPublicResponse> {
        let url = "\(baseURL)/public/users/\(userSub)"
        do {
            let data: ReadUserPublicResponse = try await NetworkManager.shared.get(urlString: url, headers: NetworkManager.shared.buildHeaders())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func updateUser(userSub: String, body: UpdateUserBody) async -> APIResponse<String> {
        let url = "\(baseURL)/private/users/\(userSub)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: String = try await NetworkManager.shared.patch(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func privateCreateThing(thing: Thing) async -> APIResponse<CreateThingResponse> {        
        let url = "\(baseURL)/private/things"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateThingResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: thing)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
}
