//
//  VoiceCallHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import SwiftUI

struct VoiceCallHubScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var events: [VideoCallEvent] = []
    
    var body: some View {
        List {
            ForEach(events, id: \.user?.userId) { event in
                Button(action: {
                    
                }) {
                    Text(event.user?.preferredName ?? event.user?.firstName ?? "")
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
            break
        case .failure(let error):
            break
        }
    }
}
