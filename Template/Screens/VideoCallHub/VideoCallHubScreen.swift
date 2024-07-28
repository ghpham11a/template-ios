//
//  VideoCallHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import SwiftUI

struct VideoCallHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [VideoCallEvent] = []
    
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
                                if event.videoCall == nil {
                                    LoadingButton(
                                        title: "Create video call",
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
                                    
                                    LoadingButton(title: "Enter video call", isLoading: false, isEnabled: true, action: {
                                        path.append(Route.videoCall(id: event.videoCall?.id ?? ""))
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
                                                await deleteVideoCall(id: event.videoCall?.id ?? "", userId: event.user?.userId ?? "")
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
            var newEvents = [VideoCallEvent]()
            var loadingStates: [String: Bool] = [:]
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newEvents.append(VideoCallEvent(user: user))
                    loadingStates[user.userId ?? ""] = false
                }
            }
            events = newEvents
            isLoadingStates = loadingStates
            await fetchVideoCalls(refresh: refresh)
        case .failure(let error):
            break
        }
    }
    
    private func fetchVideoCalls(refresh: Bool = false) async {
        if let response = await EventsRepository.shared.fetchVideoCalls(refresh: refresh) {
            var newEvents = [VideoCallEvent]()
            for event in events {
                if let call = response.first(where: { $0.receiverId == event.user?.userId || $0.senderId == event.user?.userId }) {
                    newEvents.append(VideoCallEvent(user: event.user, videoCall: call))
                } else {
                    newEvents.append(event)
                }
            }
            events = newEvents
        }
    }
    
    private func createVideoCall(event: VideoCallEvent) async {
        
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
    
    private func deleteVideoCall(id: String, userId: String) async {
        
        toggleLoadingStates(userId: userId)
        
        let response = await APIGatewayService.shared.deleteVideoCall(id: id)
        
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

