//
//  VoiceCallHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import SwiftUI

struct VoiceCallHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [VoiceCallEvent] = []
    
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
                                if event.voiceCall == nil {
                                    LoadingButton(
                                        title: "Create voice call",
                                        isLoading: Binding(
                                            get: { value },
                                            set: { isLoadingStates[userId] = $0 }
                                        ),
                                        isEnabled: true,
                                        action: {
                                            Task {
                                                await createVideoCall(event: event)
                                            }
                                        }
                                    )
                                } else {
                                    
                                    LoadingButton(title: "Enter voice call", isLoading: false, isEnabled: true, action: {
                                        path.append(Route.voiceCall(id: event.voiceCall?.id ?? ""))
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
                                                await deleteVoiceCall(id: event.voiceCall?.id ?? "", userId: event.user?.userId ?? "")
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
            var newEvents = [VoiceCallEvent]()
            var loadingStates: [String: Bool] = [:]
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newEvents.append(VoiceCallEvent(user: user))
                    loadingStates[user.userId ?? ""] = false
                }
            }
            events = newEvents
            isLoadingStates = loadingStates
            await fetchVoiceCalls(refresh: refresh)
        case .failure(let error):
            break
        }
    }
    
    private func fetchVoiceCalls(refresh: Bool = false) async {
        if let response = await EventsRepository.shared.fetchVoiceCalls(refresh: refresh) {
            var newEvents = [VoiceCallEvent]()
            for event in events {
                if let call = response.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
                    newEvents.append(VoiceCallEvent(user: event.user, voiceCall: call))
                } else {
                    newEvents.append(event)
                }
            }
            events = newEvents
        }
    }
    
    private func createVideoCall(event: VoiceCallEvent) async {
        
        toggleLoadingStates(userId: event.user?.userId ?? "")
        
        let body = CreateVoiceCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.createVoiceCall(body: body)
        
        toggleLoadingStates(userId: event.user?.userId ?? "")
        
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
        case .failure(let error):
            break
        }
    }
    
    private func deleteVoiceCall(id: String, userId: String) async {
        
        toggleLoadingStates(userId: userId)
        
        let response = await APIGatewayService.shared.deleteVoiceCall(id: id)
        
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
