//
//  TimeHelpers.swift
//  Template
//
//  Created by Anthony Pham on 8/1/24.
//

import Foundation

class TimeHelpers {
    
    static let shared = TimeHelpers()
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    func getDatesInRange(from: Int = -2, to: Int = 14) -> [String] {
        // Get the current date
        let currentDate = Date()
        
        // Calculate the start and end dates
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: from, to: currentDate)!
        let twoWeeksLater = Calendar.current.date(byAdding: .day, value: to, to: currentDate)!
        
        // Initialize the date to the start date
        var date = twoDaysAgo
        
        // Array to hold the formatted date strings
        var dateStrings: [String] = []
        
        // Loop through each date in the range
        while date <= twoWeeksLater {
            // Convert the date to a string
            let dateString = dateFormatter.string(from: date)
            
            // Append the date string to the array
            dateStrings.append(dateString)
            
            // Move to the next date
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        
        
        return dateStrings
    }
}
