//
//  APIGatewayService+Private.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import Foundation

extension APIGatewayService {
    
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
    
    func privateUpdateUser(userSub: String, body: UpdateUserBody) async -> APIResponse<UpdateUserPrivateResponse> {
        let url = "\(baseURL)/private/users/\(userSub)"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: UpdateUserPrivateResponse = try await NetworkManager.shared.patch(urlString: url, headers: headers, body: body)
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
    
    func privateCreatePaymentSetupIntent() async -> APIResponse<CreateSetupIntentResponse> {
        let url = "\(baseURL)/private/users/\(UserRepo.shared.userId ?? "")/payments/setup-intent"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let request = CreateSetupIntentRequest(stripeCustomerId: UserRepo.shared.userPrivate?.stripeCustomerId ?? "")
            let data: CreateSetupIntentResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: request)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func privateReadPaymentMethods() async -> APIResponse<ReadPaymentMethodsResponse> {
        let url = "\(baseURL)/private/users/\(UserRepo.shared.userId ?? "")/payments"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadPaymentMethodsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["customerId": UserRepo.shared.userPrivate?.stripeCustomerId ?? ""], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
    
    func privateReadPayoutMethods() async -> APIResponse<ReadPayoutMethodsResponse> {
        let url = "\(baseURL)/private/users/\(UserRepo.shared.userId ?? "")/payouts"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: ReadPayoutMethodsResponse = try await NetworkManager.shared.get(urlString: url, queryParams: ["accountId": UserRepo.shared.userPrivate?.stripeConnectedAccountId ?? ""], headers: headers)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
