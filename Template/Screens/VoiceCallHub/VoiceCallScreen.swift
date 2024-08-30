//
//  VoiceCallScreen.swift
//  Template
//
//  Created by Anthony Pham on 8/29/24.
//

import AzureCommunicationCalling
import AVFoundation
import SwiftUI

struct VoiceCallScreen: View {
    
    @Binding var path: NavigationPath
    @State var id: String
    
    @State var callee: String = ""
    @State var callClient: CallClient?
    @State var callAgent: CallAgent?
    @State var call: Call?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: startCall) {
                    Text("Start Call")
                }.disabled(callAgent == nil)
                Button(action: endCall) {
                    Text("End Call")
                }.disabled(call == nil)
            }
        }
        .onAppear {
            createCallAgent()
        }
    }
    
    func createCallAgent() {
        var userCredential: CommunicationTokenCredential?
        do {
            userCredential = try CommunicationTokenCredential(token: getAccessToken())
        } catch {
            print("ERROR: It was not possible to create user credential.")
            return
        }

        self.callClient = CallClient()

        // Creates the call agent
        self.callClient?.createCallAgent(userCredential: userCredential!) { (agent, error) in
            if error != nil {
                print("ERROR: It was not possible to create a call agent.")
                return
            }
            else {
                self.callAgent = agent
                print("Call agent successfully created.")
            }
        }
    }
    
    func startCall() {
        // Ask permissions
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                // start call logic
                let callees:[CommunicationIdentifier] = [CommunicationUserIdentifier(getIdentity())]
                self.callAgent?.startCall(participants: callees, options: StartCallOptions()) { (call, error) in
                    if (error == nil) {
                        self.call = call
                    } else {
                        print("Failed to get call object")
                    }
                }
            }
        }
    }

    func endCall() {
        self.call!.hangUp(options: HangUpOptions()) { (error) in
            if (error != nil) {
                print("ERROR: It was not possible to hangup the call.")
            }
        }
    }
    
    func getAccessToken() -> String {
        if let event = EventsRepository.shared.voiceCalls?.filter({ $0.id == id }).first {
            if event.senderId == UserRepo.shared.userId, let token = event.senderToken {
                return token
            }
            if event.receiverId == UserRepo.shared.userId, let token = event.receiverToken {
                return token
            }
        }
        return ""
    }
    
    func getIdentity() -> String {
        if let event = EventsRepository.shared.voiceCalls?.filter({ $0.id == id }).first {
            if event.senderId == UserRepo.shared.userId, let identity = event.receiverIdentity {
                return identity
            }
            if event.receiverId == UserRepo.shared.userId, let identity = event.senderIdentity {
                return identity
            }
        }
        return ""
    }
}
