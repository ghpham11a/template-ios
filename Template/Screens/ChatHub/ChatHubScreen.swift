//
//  ChatHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import SwiftUI

struct ChatHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [ChatEvent] = []
    
    @State var isLoadingStates: [String: Bool] = [:]
    
    var body: some View {
        List {
            ForEach(events, id: \.user?.userId) { event in
                HStack {
                    VStack {
                        Text(event.user?.preferredName ?? event.user?.firstName ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        HStack {
                            if let userId = event.user?.userId, let value = isLoadingStates[userId] {
                                if event.chat == nil {
                                    LoadingButton(
                                        title: "Create chat",
                                        isLoading: Binding(
                                            get: { value },
                                            set: { isLoadingStates[userId] = $0 }
                                        ),
                                        isEnabled: true,
                                        action: {
                                            Task {
                                                await createChat(event: event)
                                            }
                                        }
                                    )
                                } else {
                                    
                                    LoadingButton(title: "Enter chat", isLoading: false, isEnabled: true, action: {
                                        // path.append(Route.cha(id: event.videoCall?.id ?? ""))
                                    })
                                    
                                    Spacer()
                                    
                                    LoadingButton(
                                        title: "Delete",
                                        isLoading: Binding(
                                            get: { value },
                                            set: { isLoadingStates[userId] = $0 }
                                        ),
                                        isEnabled: true,
                                        action: {
                                            Task {
                                                await deleteChat(id: event.chat?.id ?? "", userId: event.user?.userId ?? "")
                                            }
                                        }
                                    )
                                }
                            }
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
            var newEvents = [ChatEvent]()
            var loadingStates: [String: Bool] = [:]
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newEvents.append(ChatEvent(user: user))
                    loadingStates[user.userId ?? ""] = false
                }
            }
            events = newEvents
            isLoadingStates = loadingStates
            await fetchChats(refresh: refresh)
        case .failure(let error):
            break
        }
    }
    
    private func fetchChats(refresh: Bool = false) async {
        if let response = await EventsRepository.shared.fetchChats(refresh: refresh) {
            var newEvents = [ChatEvent]()
            for event in events {
                if let call = response.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
                    newEvents.append(ChatEvent(user: event.user, chat: call))
                } else {
                    newEvents.append(event)
                }
            }
            events = newEvents
        }
    }
    
    private func createChat(event: ChatEvent) async {
        
        toggleLoadingStates(userId: event.user?.userId ?? "")
        
        let body = CreateVideoCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.createVideoCall(body: body)
        
        toggleLoadingStates(userId: event.user?.userId ?? "")
        
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
        case .failure(let error):
            break
        }
    }
    
    private func deleteChat(id: String, userId: String) async {
        
        toggleLoadingStates(userId: userId)
        
        let response = await APIGatewayService.shared.deleteChat(id: id)
        
        toggleLoadingStates(userId: userId)
        
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
        case .failure(let error):
            break
        }
    }
    
    private func toggleLoadingStates(userId: String) {
        var oldCopy = isLoadingStates
        oldCopy[userId]?.toggle()
        isLoadingStates = oldCopy
    }
}
