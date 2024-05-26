//
//  Todo.swift
//  Template
//
//  Created by Anthony Pham on 5/23/24.
//

import Foundation

struct Todo: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
