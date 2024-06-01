//
//  CheckIfUserExistsResponse.swift
//  Template
//
//  Created by Anthony Pham on 5/30/24.
//

import Foundation

struct CheckIfUserExistsResponse: Codable {
    let data: Data
    let message: String
}

struct Data: Codable {
    let enabled: Bool
    let responseMetadata: ResponseMetadata
    let userAttributes: [UserAttribute]
    let userCreateDate: String
    let userLastModifiedDate: String
    let userStatus: String
    let username: String

    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case responseMetadata = "ResponseMetadata"
        case userAttributes = "UserAttributes"
        case userCreateDate = "UserCreateDate"
        case userLastModifiedDate = "UserLastModifiedDate"
        case userStatus = "UserStatus"
        case username = "Username"
    }
}

struct ResponseMetadata: Codable {
    let httpHeaders: HTTPHeaders
    let httpStatusCode: Int
    let requestId: String
    let retryAttempts: Int

    enum CodingKeys: String, CodingKey {
        case httpHeaders = "HTTPHeaders"
        case httpStatusCode = "HTTPStatusCode"
        case requestId = "RequestId"
        case retryAttempts = "RetryAttempts"
    }
}

struct HTTPHeaders: Codable {
    let connection: String
    let contentLength: String
    let contentType: String
    let date: String
    let xAmznRequestId: String

    enum CodingKeys: String, CodingKey {
        case connection = "connection"
        case contentLength = "content-length"
        case contentType = "content-type"
        case date = "date"
        case xAmznRequestId = "x-amzn-requestid"
    }
}

struct UserAttribute: Codable {
    let name: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
    }
}
