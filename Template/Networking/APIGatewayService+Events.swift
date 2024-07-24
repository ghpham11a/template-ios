//
//  APIGatewayService+Events.swift
//  Template
//
//  Created by Anthony Pham on 7/22/24.
//

import Foundation

extension APIGatewayService {
    
    func readProxyCalls(userId: String) async -> APIResponse<ReadProxyCallsResponse> {
        let url = "\(baseURL)/events/proxy-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadProxyCallsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["userId": userId], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func createProxyCall(body: CreateProxyCallRequest) async -> APIResponse<CreateProxyCallResponse> {
        let url = "\(baseURL)/events/proxy-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateProxyCallResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func deleteProxyCall(id: String) async -> APIResponse<CreateProxyCallResponse> {
        let url = "\(baseURL)/events/proxy-calls/\(id)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateProxyCallResponse = try await NetworkManager.shared.delete(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func readVideoCalls(userId: String) async -> APIResponse<ReadVideoCallsResponse> {
        let url = "\(baseURL)/events/video-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadVideoCallsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["userId": userId], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func createVideoCall(body: CreateVideoCallRequest) async -> APIResponse<CreateVideoCallResponse> {
        let url = "\(baseURL)/events/video-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateVideoCallResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func deleteVideoCall(id: String) async -> APIResponse<CreateVideoCallResponse> {
        let url = "\(baseURL)/events/video-calls/\(id)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateVideoCallResponse = try await NetworkManager.shared.delete(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
