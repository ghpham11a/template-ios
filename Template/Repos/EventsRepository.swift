//
//  EventsRepository.swift
//  Template
//
//  Created by Anthony Pham on 7/22/24.
//

import Foundation

class EventsRepository: ObservableObject {
    
    static let shared = EventsRepository()
    
    var userId: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_SUB) as? String
    }
    var idToken: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_ID_TOKEN) as? String
    }
    var username: String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: Constants.USER_DEFAULTS_KEY_USERNAME) as? String
    }
    
    var proxyCalls: [ProxyCall]? = nil
    var videoCalls: [VideoCall]? = nil
    
    func fetchProxyCalls(refresh: Bool = false) async -> [ProxyCall]? {
        
        if proxyCalls != nil && !refresh {
            return proxyCalls
        }
        
        let response = await APIGatewayService.shared.readProxyCalls(userId: UserRepo.shared.userId ?? "")
        switch response {
        case .success(let data):
            proxyCalls = data.calls
            return proxyCalls
        case .failure(let error):
            return nil
        }
    }
    
    func fetchVideoCalls(refresh: Bool = false) async -> [VideoCall]? {
        
        if videoCalls != nil && !refresh {
            return videoCalls
        }
        
        let response = await APIGatewayService.shared.readVideoCalls(userId: UserRepo.shared.userId ?? "")
        switch response {
        case .success(let data):
            videoCalls = data.calls
            return videoCalls
        case .failure(let error):
            return nil
        }
    }
}
