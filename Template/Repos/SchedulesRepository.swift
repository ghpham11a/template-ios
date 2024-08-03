//
//  SchedulesRepository.swift
//  Template
//
//  Created by Anthony Pham on 8/2/24.
//

import Foundation

class SchedulesRepository: ObservableObject {
    
    static let shared = SchedulesRepository()
    
    @Published var conflict: Block = Block(id: "IGNORE", dateKey: Date().ISO8601Format(), startTime: Date(), endTime: Date())
    
    var duration: Int = 0
    
    var user: ReadUserPublicResponse? = nil
    var userId: String? = nil
    
    func updateConflict(time: Time) {
        conflict = Block(id: UUID().uuidString, dateKey: TimeHelpers.shared.dateFormatter.string(from: time.start), startTime: time.start, endTime: time.end)
    }
}
