//
//  JwtPayload.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import Foundation

struct JwtPayload: Decodable {
    var skypeid: String
    var exp: UInt64
}
