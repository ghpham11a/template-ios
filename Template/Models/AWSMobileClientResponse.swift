//
//  AWSMobileClientResponse.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import Foundation

struct AWSMobileClientResponse<T> {
    let isSuccessful: Bool?
    let result: T?
    let exception: String?
}
