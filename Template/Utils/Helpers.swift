//
//  Helpers.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import Foundation

func parseRouteParams(from urlString: String) -> [String: String] {
    var params = [String: String]()
    
    // Separate the URL components
    guard let urlComponents = URLComponents(string: urlString) else {
        return params
    }
    
    // Extract the query items
    if let queryItems = urlComponents.queryItems {
        for item in queryItems {
            if let value = item.value {
                params[item.name] = value
            }
        }
    }
    
    return params
}
