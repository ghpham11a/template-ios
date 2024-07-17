//
//  PaymentAmountScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/14/24.
//

import SwiftUI

struct PaymentAmountScreen: View {
    
    @Binding var path: NavigationPath
    @State var accountId: String
    
    @State private var amount: String = ""
    
    @State private var isLoading: Bool = false
    @State private var isSendPaymentEnabled: Bool = true

    var body: some View {
        VStack {
            VStack {
                Text("$\(amount)")
                    .font(.largeTitle)
                    .padding()

                Numpad { input in
                    if input == "<-" {
                        if !amount.isEmpty {
                            amount.removeLast()
                        }
                    } else if input == "." && amount.contains(".") {
                        // Do nothing if the amount already contains a decimal point
                    } else {
                        amount += input
                    }
                }
            }
            
            Spacer()
            
            VStack {
                LoadingButton(title: "Send payment", isLoading: $isLoading, isEnabled: $isSendPaymentEnabled, action: {
                    Task {
                        await sendPayment()
                    }
                })
            }
            .padding()
        }
    }
    
    private func sendPayment() async {
        let response = await APIGatewayService.shared.stripeCreatePaymentIntent(body: CreatePaymentIntentRequest(customerId: UserRepo.shared.userPrivate?.user?.stripeCustomerId ?? "", accountId: accountId, amount: amount))
        switch response {
        case .success(let data):
            path.removeLast()
            break
        case .failure(let error):
            break
        }
    }
}
