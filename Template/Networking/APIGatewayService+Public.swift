//
//  APIGatewayService+Public.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import Foundation

extension APIGatewayService {
    
    func publicReadUser(userSub: String) async -> APIResponse<ReadUserPublicResponse> {
        let url = "\(baseURL)/public/users/\(userSub)"
        do {
            let data: ReadUserPublicResponse = try await NetworkManager.shared.get(urlString: url, headers: NetworkManager.shared.buildHeaders())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func readUsers() async -> APIResponse<ReadUsersResponse> {
        let url = "\(baseURL)/users"
        do {
            let data: ReadUsersResponse = try await NetworkManager.shared.get(urlString: url, headers: NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? ""))
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
