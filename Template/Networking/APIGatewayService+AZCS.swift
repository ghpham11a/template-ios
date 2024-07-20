//
//  APIGatewayService+AZCS.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import Foundation

extension APIGatewayService {
    func azcsCreateAccessToken() async -> APIResponse<CreateAZCSAccessTokenResponse> {
        let url = "\(baseURL)/azcs/access-tokens"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateAZCSAccessTokenResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
