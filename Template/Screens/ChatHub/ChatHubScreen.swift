//
//  ChatHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import SwiftUI

struct ChatHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var users: [DynamoDBUser] = []
    
    var body: some View {
        List {
            ForEach(users, id: \.userId) { user in
                Button(action: {
                    
                }) {
                    Text(user.preferredName ?? user.firstName ?? "")
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
