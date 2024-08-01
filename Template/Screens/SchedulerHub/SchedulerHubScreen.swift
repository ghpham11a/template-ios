//
//  SchedulerHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/31/24.
//

import SwiftUI

struct SchedulerHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var users: [DynamoDBUser] = []
    
    var body: some View {
        List {
            ForEach(users, id: \.userId) { user in
                HStack {
                    VStack {
                        Text(user.preferredName ?? user.firstName ?? user.email ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        VStack {
                            LoadingButton(title: "Schedule Type 1", isLoading: false, isEnabled: true, action: {
                                path.append(Route.schedulerScreen(userId: user.userId ?? "", availabilityType: "1"))
                            })
                            LoadingButton(title: "Schedule Type 2", isLoading: false, isEnabled: true, action: {
                                path.append(Route.schedulerScreen(userId: user.userId ?? "", availabilityType: "2"))
                            })
                            LoadingButton(title: "Schedule Type 3", isLoading: false, isEnabled: true, action: {
                                path.append(Route.schedulerScreen(userId: user.userId ?? "", availabilityType: "3"))
                            })
                            LoadingButton(title: "Schedule Type 4", isLoading: false, isEnabled: true, action: {
                                path.append(Route.schedulerScreen(userId: user.userId ?? "", availabilityType: "4"))
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .onAppear {
            Task {
                await fetchUsers()
            }
        }
    }
    
    private func fetchUsers(refresh: Bool = false) async {
        let response = await APIGatewayService.shared.readUsers()
        switch response {
        case .success(let data):
            var newUsers = [DynamoDBUser]()
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newUsers.append(user)
                }
            }
            users = newUsers
        case .failure(let error):
            break
        }
    }
    
    private func fetchChats(refresh: Bool = false) async {
//        if let response = await EventsRepository.shared.fetchChats(refresh: refresh) {
//            var newEvents = [ChatEvent]()
//            for event in events {
//                if let call = response.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
//                    newEvents.append(ChatEvent(user: event.user, chat: call))
//                } else {
//                    newEvents.append(event)
//                }
//            }
//            events = newEvents
//        }
    }
}
