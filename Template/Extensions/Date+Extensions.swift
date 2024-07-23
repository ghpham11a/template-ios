//
//  Date+Extensions.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import Foundation

extension Date {
    static func from(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
}
