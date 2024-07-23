//
//  CallKitHelper.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import Foundation
import CallKit

final class CallKitHelper {

    static func createCXProvideConfiguration() -> CXProviderConfiguration {
        let providerConfig = CXProviderConfiguration()
        providerConfig.supportsVideo = true
        providerConfig.maximumCallsPerCallGroup = 1
        providerConfig.includesCallsInRecents = true
        providerConfig.supportedHandleTypes = [.phoneNumber, .generic]
        return providerConfig
    }
}
