//
//  SendPaymentHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/13/24.
//

import SwiftUI

struct SendPaymentHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var users: [DynamoDBUser] = []
    
    var body: some View {
        List {
            ForEach(users, id: \.userId) { user in
                Button(action: {
                    path.append(Route.paymentAmount(accountId: user.stripeAccountId ?? ""))
                }) {
                    Text(user.email ?? "")
                }
            }
        }
        .onAppear {
            Task {
                await fetchUsers()
            }
        }
    }
    
    private func fetchUsers() async {
        let response = await APIGatewayService.shared.readUsers()
        switch response {
        case .success(let data):
            users = data.users ?? []
            break
        case .failure(let error):
            break
        }
    }
}
