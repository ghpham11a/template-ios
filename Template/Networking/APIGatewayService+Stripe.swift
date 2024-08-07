//
//  APIGatewayService+Stripe.swift
//  Template
//
//  Created by Anthony Pham on 7/14/24.
//

import Foundation

extension APIGatewayService {
    
    func stripeCreatePaymentIntent(body: CreatePaymentIntentRequest) async -> APIResponse<CreatePaymentIntentResponse> {
        let url = "\(baseURL)/stripe/payment-intents"
        let headers = NetworkManager.shared.buildAuthorizedHeaders(token: UserRepo.shared.idToken ?? "")
        do {
            let data: CreatePaymentIntentResponse = try await NetworkManager.shared.post(urlString: url, headers: headers, body: body)
            return .success(data)
        } catch {
            return .failure(APIError(message: String(describing: error), code: 500))
        }
    }
}
