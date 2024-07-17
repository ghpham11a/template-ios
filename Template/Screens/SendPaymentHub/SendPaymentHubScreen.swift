//
//  SendPaymentHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/13/24.
//

import SwiftUI

struct SendPaymentHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var receivers: [PaymentReceiver] = []
    
    var body: some View {
        List {
            ForEach(receivers, id: \.accountId) { receiver in
                Button(action: {
                    path.append(Route.paymentAmount(accountId: receiver.accountId ?? ""))
                }) {
                    Text(receiver.email ?? "")
                }
            }
        }
        .onAppear {
            Task {
                await fetchStripeAccounts()
            }
        }
    }

    private func fetchStripeAccounts() async {
        let response = await APIGatewayService.shared.stripeReadAccounts()
        switch response {
        case .success(let data):
            receivers = data.accounts ?? []
            break
        case .failure(let error):
            break
        }
    }
    
}
