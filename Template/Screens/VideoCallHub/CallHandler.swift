//
//  CallHandler.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import Foundation
import AzureCommunicationCalling

public class CallHandlerBase: NSObject {
    private var owner: VideoCallScreen
    private var callKitHelper: CallKitHelper?

    init(_ view: VideoCallScreen) {
        owner = view
    }
    
    public func onStateChanged(call: CommonCall, args: PropertyChangedEventArgs) {
        switch call.state {
        case .connected:
            owner.callState = "Connected"
            break
        case .connecting:
            owner.callState = "Connecting"
            break
        case .disconnected:
            owner.callState = "Disconnected"
            break
        case .disconnecting:
            owner.callState = "Disconnecting"
            break
        case .inLobby:
            owner.callState = "InLobby"
            break
        case .localHold:
            owner.callState = "LocalHold"
            break
        case .remoteHold:
            owner.callState = "RemoteHold"
            break
        case .ringing:
            owner.callState = "Ringing"
            break
        case .earlyMedia:
            owner.callState = "EarlyMedia"
            break
        case .none:
            owner.callState = "None"
            break
        default:
            owner.callState = "Default"
            break
        }

        if call.state == CallState.connected {
            initialCallParticipant()
        }
    }

    public func onRemoteParticipantUpdated(call: CommonCall, args: ParticipantsUpdatedEventArgs) {
        for participant in args.addedParticipants {
            participant.delegate = owner.remoteParticipantObserver
            for stream in participant.videoStreams {
                if !owner.remoteVideoStreamData.isEmpty {
                    return
                }
                let data:RemoteVideoStreamData = RemoteVideoStreamData(view: owner, stream: stream)
                let scalingMode = ScalingMode.fit
                data.renderer = try! VideoStreamRenderer(remoteVideoStream: stream)
                let view:RendererView = try! data.renderer!.createView(withOptions: CreateViewOptions(scalingMode:scalingMode))
                data.rendererView = view
                owner.remoteVideoStreamData.append(data)
            }
            owner.remoteParticipant = participant
        }
    }
    
    public func onOutgoingAudioStateChanged(call: CommonCall) {
        owner.isMuted = call.isOutgoingAudioMuted
    }

    private func renderRemoteStream(_ stream: RemoteVideoStream!) {
        if !owner.remoteVideoStreamData.isEmpty {
            return
        }
        let data: RemoteVideoStreamData = RemoteVideoStreamData(view: owner, stream: stream)
        let scalingMode = ScalingMode.fit
        data.renderer = try! VideoStreamRenderer(remoteVideoStream: stream)
        let view:RendererView = try! data.renderer!.createView(withOptions: CreateViewOptions(scalingMode:scalingMode))
        data.rendererView = view
        owner.remoteVideoStreamData.append(data)
    }

    public func onMutedByRemoteParticipant() {
        owner.showAlert = true
        owner.alertMessage = "You were muted by another participant in the call !!"
    }

    private func initialCallParticipant() {
        var callBase: CommonCall?
        if let call = owner.call {
            callBase = call
        } else if let call = owner.teamsCall {
            callBase = call
        }
        
        guard let callBase = callBase else {
            return
        }
        
        for participant in callBase.remoteParticipants {
            participant.delegate = owner.remoteParticipantObserver
            for stream in participant.videoStreams {
                renderRemoteStream(stream)
            }
            owner.remoteParticipant = participant
        }
    }
}

public final class CallHandler: CallHandlerBase, CallDelegate, IncomingCallDelegate {
    
    override init(_ view: VideoCallScreen) {
        super.init(view)
    }

    public func call(_ call: Call, didChangeState args: PropertyChangedEventArgs) {
        onStateChanged(call: call, args: args)
    }
    
    public func call(_ call: Call, didUpdateOutgoingAudioState args: PropertyChangedEventArgs) {
        onOutgoingAudioStateChanged(call: call)
    }

    public func call(_ call: Call, didUpdateRemoteParticipant args: ParticipantsUpdatedEventArgs) {
        onRemoteParticipantUpdated(call: call, args: args)
    }
    
    public func call(_ call: Call, didChangeId args: PropertyChangedEventArgs) {
        print("ACSCall New CallId: \(call.id)")
    }
    
    #if BETA
    public func call(_ call: Call, didGetMutedByOthers args: PropertyChangedEventArgs) {
        onMutedByRemoteParticipant()
    }
    #endif
}

public final class TeamsCallHandler: CallHandlerBase, TeamsCallDelegate, TeamsIncomingCallDelegate {
    
    override init(_ view: VideoCallScreen) {
        super.init(view)
    }
    
    public func teamsCall(_ teamsCall: TeamsCall, didChangeState args: PropertyChangedEventArgs) {
        onStateChanged(call: teamsCall, args: args)
    }
    
    public func teamsCall(_ teamsCall: TeamsCall, didUpdateOutgoingAudioState args: PropertyChangedEventArgs) {
        onOutgoingAudioStateChanged(call: teamsCall)
    }
    
    public func teamsCall(_ teamsCall: TeamsCall, didUpdateRemoteParticipant args: ParticipantsUpdatedEventArgs) {
        onRemoteParticipantUpdated(call: teamsCall, args: args)
    }
    
    public func teamsCall(_ teamsCall: TeamsCall, didChangeId args: PropertyChangedEventArgs) {
        print("TeamsCall New CallId: \(teamsCall.id)")
    }
    
    #if BETA
    public func teamsCall(_ teamsCall: TeamsCall, didGetMutedByOthers args: PropertyChangedEventArgs) {
        onMutedByRemoteParticipant()
    }
    #endif
}
