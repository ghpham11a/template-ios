//
//  APIGatewayService+Events.swift
//  Template
//
//  Created by Anthony Pham on 7/22/24.
//

import Foundation

extension APIGatewayService {
    
    // MARK: - Proxy calls
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
    
    // MARK: - Video calls
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
    
    // MARK: - Voice calls
    func readVoiceCalls(userId: String) async -> APIResponse<ReadVoiceCallsResponse> {
        let url = "\(baseURL)/events/voice-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadVoiceCallsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["userId": userId], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func createVoiceCall(body: CreateVoiceCallRequest) async -> APIResponse<CreateVoiceCallResponse> {
        let url = "\(baseURL)/events/voice-calls"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateVoiceCallResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func deleteVoiceCall(id: String) async -> APIResponse<CreateVoiceCallResponse> {
        let url = "\(baseURL)/events/voice-calls/\(id)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateVoiceCallResponse = try await NetworkManager.shared.delete(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    // MARK: - Chats
    func readChats(userId: String) async -> APIResponse<ReadChatsResponse> {
        let url = "\(baseURL)/events/chats"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadChatsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["userId": userId], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func createChat(body: CreateChatRequest) async -> APIResponse<CreateChatResponse> {
        let url = "\(baseURL)/events/chats"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateChatResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func deleteChat(id: String) async -> APIResponse<CreateChatResponse> {
        let url = "\(baseURL)/events/chats/\(id)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreateChatResponse = try await NetworkManager.shared.delete(urlString: url, headers: headers, body: EmptyBody())
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
