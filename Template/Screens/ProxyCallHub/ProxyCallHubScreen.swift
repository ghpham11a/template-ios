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
                            } else {
                                Button(action: {
                                    if let url = URL(string: "tel://\(getPhoneNumber(event: event))") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("Call")
                                }
                                Button(action: {

                                }) {
                                    Text("Delete")
                                }
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

    private func fetchUsers() async {
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
            await fetchProxyCalls()
            break
        case .failure(let error):
            break
        }
    }
    
    private func fetchProxyCalls() async {
        let response = await APIGatewayService.shared.privateReadProxyCalls(userId: UserRepo.shared.userId ?? "")
        switch response {
        case .success(let data):
            var newEvents = [ProxyCallEvent]()
            var proxyCalls = data.calls ?? []
            for event in events {
                if let call = proxyCalls.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
                    newEvents.append(ProxyCallEvent(user: event.user, proxyCall: call))
                } else {
                    newEvents.append(event)
                }
            }
            events = newEvents
            break
        case .failure(let error):
            break
        }
    }
    
    private func createProxyCall(event: ProxyCallEvent) async {
        var body = CreateProxyCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.privateCreateProxyCall(body: body)
        switch response {
        case .success(let data):
            await fetchUsers()
            break
        case .failure(let error):
            break
        }
    }
}
