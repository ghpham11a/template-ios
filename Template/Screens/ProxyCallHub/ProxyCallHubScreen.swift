//
//  ProxyCallHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/18/24.
//

import SwiftUI

struct ProxyCallHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [ProxyCallEvent] = []
    
    @State var isLoadingStates: [String: Bool] = [:]
    
    var body: some View {
        List {
            ForEach(events, id: \.user?.userId) { event in
                HStack {
                    VStack {
                        Text(event.user?.preferredName ?? event.user?.firstName ?? "")
                        
                        if let userId = event.user?.userId, let value = isLoadingStates[userId] {
                            HStack {
                                if event.proxyCall == nil {
                                    
                                    LoadingButton(
                                        title: "Create masked phone call",
                                        isLoading: Binding(
                                            get: { value },
                                            set: { isLoadingStates[userId] = $0 }
                                        ),
                                        isEnabled: true,
                                        action: {
                                            Task {
                                                await createProxyCall(event: event)
                                            }
                                        }
                                    )
                                } else {
                                    
                                    LoadingButton(title: "Call", isLoading: false, isEnabled: true, action: {
                                        if let url = URL(string: "tel://\(getPhoneNumber(event: event))") {
                                            UIApplication.shared.open(url)
                                        }
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
                                                await deleteProxyCall(id: event.proxyCall?.id ?? "", userId: event.user?.userId ?? "")
                                            }
                                        }
                                    )
                                    
                                    Button(action: {
                                        Task {
                                            await deleteProxyCall(id: event.proxyCall?.id ?? "", userId: event.user?.userId ?? "")
                                        }
                                    }) {
                                        Text("Delete")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            Task {
                await fetchUsers()
            }
        }
    }
    
    private func getPhoneNumber(event: ProxyCallEvent) -> String {
        if event.proxyCall?.senderId == UserRepo.shared.userId {
            return (event.proxyCall?.receiverProxy ?? "").replacingOccurrences(of: "+", with: "")
        }
        if event.proxyCall?.receiverId == UserRepo.shared.userId {
            return (event.proxyCall?.senderProxy ?? "").replacingOccurrences(of: "+", with: "")
        }
        return ""
    }

    private func fetchUsers(refresh: Bool = false) async {
        let response = await APIGatewayService.shared.readUsers()
        switch response {
        case .success(let data):
            var newEvents = [ProxyCallEvent]()
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newEvents.append(ProxyCallEvent(user: user))
                }
            }
            events = newEvents
            await fetchProxyCalls(refresh: refresh)
            break
        case .failure(let error):
            break
        }
    }
    
    private func fetchProxyCalls(refresh: Bool = false) async {
        if let response = await EventsRepository.shared.fetchProxyCalls(refresh: refresh) {
            var newEvents = [ProxyCallEvent]()
            for event in events {
                if let call = response.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
                    newEvents.append(ProxyCallEvent(user: event.user, proxyCall: call))
                } else {
                    newEvents.append(event)
                }
            }
            events = newEvents
        }
    }
    
    private func createProxyCall(event: ProxyCallEvent) async {
        toggleLoadingStates(userId: event.user?.userId ?? "")
        var body = CreateProxyCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.createProxyCall(body: body)
        toggleLoadingStates(userId: event.user?.userId ?? "")
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
            break
        case .failure(let error):
            break
        }
    }
    
    private func deleteProxyCall(id: String, userId: String) async {
        toggleLoadingStates(userId: userId)
        let response = await APIGatewayService.shared.deleteProxyCall(id: id)
        toggleLoadingStates(userId: userId)
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
            break
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
