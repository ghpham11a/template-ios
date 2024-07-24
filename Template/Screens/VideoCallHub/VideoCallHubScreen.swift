//
//  VideoCallHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/19/24.
//

import SwiftUI
import AzureCommunicationCommon

struct VideoCallHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [VideoCallEvent] = []
    
    var body: some View {
        List {
            ForEach(events, id: \.user?.userId) { event in
                HStack {
                    VStack {
                        Text(event.user?.preferredName ?? event.user?.firstName ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            
                            if event.videoCall == nil {
                                Button(action: {
                                    Task {
                                        await createVideoCall(event: event)
                                    }
                                }) {
                                    Text("Create masked phone call")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            } else {
                                Button(action: {
                                    path.append(Route.videoCall(id: event.videoCall?.id ?? ""))
                                }) {
                                    Text("Enter video call")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                Spacer()
                                
                                Button(action: {
                                    Task {
                                        await deleteVideoCall(id: event.videoCall?.id ?? "")
                                    }
                                }) {
                                    Text("Delete")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(0)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private func fetchUsers(refresh: Bool = false) async {
        let response = await APIGatewayService.shared.readUsers()
        switch response {
        case .success(let data):
            var newEvents = [VideoCallEvent]()
            for user in (data.users ?? []) {
                if user.userId != UserRepo.shared.userId {
                    newEvents.append(VideoCallEvent(user: user))
                }
            }
            events = newEvents
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
        var body = CreateVideoCallRequest(senderId: UserRepo.shared.userId ?? "", receiverId: event.user?.userId ?? "")
        let response = await APIGatewayService.shared.createVideoCall(body: body)
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
        case .failure(let error):
            break
        }
    }
    
    private func deleteVideoCall(id: String) async {
        let response = await APIGatewayService.shared.deleteVideoCall(id: id)
        switch response {
        case .success(let data):
            await fetchUsers(refresh: true)
        case .failure(let error):
            break
        }
    }
}

