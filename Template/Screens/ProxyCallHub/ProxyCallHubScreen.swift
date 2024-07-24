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
    
    var body: some View {
        List {
            ForEach(events, id: \.user?.userId) { event in
                HStack {
                    VStack {
                        Text(event.user?.preferredName ?? event.user?.firstName ?? "")
                        HStack {
                            if event.proxyCall == nil {
                                Button(action: {
                                    Task {
                                        await createProxyCall(event: event)
                                    }
                                }) {
                                    Text("Create masked phone call")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            } else {
                                Button(action: {
                                    if let url = URL(string: "tel://\(getPhoneNumber(event: event))") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("Call")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                Spacer()
                                
                                Button(action: {
                                    Task {
                                        await deleteProxyCall(id: event.proxyCall?.id ?? "")
                                    }
                                }) {
                                    Text("Delete")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .padding(0)
                    }
                    .padding(0)
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
        var body = CreateProxyCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.createProxyCall(body: body)
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
            break
        case .failure(let error):
            break
        }
    }
    
    private func deleteProxyCall(id: String) async {
        let response = await APIGatewayService.shared.deleteProxyCall(id: id)
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
            break
        case .failure(let error):
            break
        }
    }
}
