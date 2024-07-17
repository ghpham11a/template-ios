//
//  ReadProxyCalls.swift
//  Template
//
//  Created by Anthony Pham on 7/15/24.
//

import Foundation

struct ReadProxyCallsResponse: Codable {
    var calls: [ProxyCall]? = nil
    
    enum CodingKeys: String, CodingKey {
        case calls = "calls"
    }
}
