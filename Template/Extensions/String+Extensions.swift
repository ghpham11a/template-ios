//
//  String+Extensions.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
