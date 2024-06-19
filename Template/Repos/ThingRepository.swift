//
//  ThingRepository.swift
//  Template
//
//  Created by Anthony Pham on 6/18/24.
//

import Foundation

class ThingRepository: ObservableObject {
    
    static let shared = ThingRepository()
    
    func createThing(thing: Thing) async -> APIResponse<CreateThingResponse> {
        
        let response = await APIGatewayService.shared.privateCreateThing(thing: thing)
        switch response {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
