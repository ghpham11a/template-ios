//
//  AppsPub.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import SwiftUI
import PushKit
import Combine
import AzureCommunicationCalling

class AppPubs {
    init() {
        self.pushPayload = nil
        self.pushToken = nil
    }

    @Published var pushPayload: PKPushPayload?
    @Published var pushToken: Data?
}
