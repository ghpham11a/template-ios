//
//  NetworkManager.swift
//  Template
//
//  Created by Anthony Pham on 5/23/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func buildAuthorizedHeaders(token: String) -> [String: String] {
        
        var headers: [String: String] = [:]
        
        let seconds = TimeZone.current.secondsFromGMT()
        let hours = seconds/3600
        let minutes = abs(seconds/60) % 60
        let tz = String(format: "%+.1d:%.2d", hours, minutes)
        
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(token)"
        headers["Platform"] = "apn"
        headers["Utc-Offset"] = tz
        
        return headers
    }
    
    func buildHeaders() -> [String: String] {
        
        var headers: [String: String] = [:]
        
        let seconds = TimeZone.current.secondsFromGMT()
        let hours = seconds/3600
        let minutes = abs(seconds/60) % 60
        let tz = String(format: "%+.1d:%.2d", hours, minutes)
        
        headers["Content-Type"] = "application/json"
        headers["Platform"] = "apn"
        headers["Utc-Offset"] = tz
        
        return headers
    }
    
    func get<T: Codable>(urlString: String, queryParams: [String: String] = [:], headers: [String: String] = [:]) async throws -> T {
            
        var formattedUrl = urlString
        
        if !queryParams.isEmpty {
            formattedUrl += "?"
            let queryParamsArray = Array(queryParams)
            for (index, element) in queryParamsArray.enumerated() {
                formattedUrl += "\(element.key)=\(element.value)"
                if index < queryParamsArray.count - 1 {
                    formattedUrl += "&"
                }
            }
        }
        
        guard let url = URL(string: formattedUrl) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if !headers.isEmpty {
            let headersArray = Array(headers)
            for (_, element) in headersArray.enumerated() {
                request.addValue(element.value, forHTTPHeaderField: element.key)
            }
        }

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    func put<T: Codable>(urlString: String, queryParams: [String: String] = [:], headers: [String: String] = [:], body: [String: Any]) async throws -> T {
        var formattedUrl = urlString

        if !queryParams.isEmpty {
            formattedUrl += "?"
            let queryParamsArray = Array(queryParams)
            for (index, element) in queryParamsArray.enumerated() {
                formattedUrl += "\(element.key)=\(element.value)"
                if index < queryParamsArray.count - 1 {
                    formattedUrl += "&"
                }
            }
        }

        guard let url = URL(string: formattedUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        if !headers.isEmpty {
            let headersArray = Array(headers)
            for (_, element) in headersArray.enumerated() {
                request.addValue(element.value, forHTTPHeaderField: element.key)
            }
        }

        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    func patch<T: Codable>(urlString: String, queryParams: [String: String] = [:], headers: [String: String] = [:], body: [String: Any]) async throws -> T {
        var formattedUrl = urlString

        if !queryParams.isEmpty {
            formattedUrl += "?"
            let queryParamsArray = Array(queryParams)
            for (index, element) in queryParamsArray.enumerated() {
                formattedUrl += "\(element.key)=\(element.value)"
                if index < queryParamsArray.count - 1 {
                    formattedUrl += "&"
                }
            }
        }

        guard let url = URL(string: formattedUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"

        if !headers.isEmpty {
            let headersArray = Array(headers)
            for (_, element) in headersArray.enumerated() {
                request.addValue(element.value, forHTTPHeaderField: element.key)
            }
        }

        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    func post<T: Codable>(urlString: String, queryParams: [String: String] = [:], headers: [String: String] = [:], body: [String: Any]) async throws -> T {
        var formattedUrl = urlString

        if !queryParams.isEmpty {
            formattedUrl += "?"
            let queryParamsArray = Array(queryParams)
            for (index, element) in queryParamsArray.enumerated() {
                formattedUrl += "\(element.key)=\(element.value)"
                if index < queryParamsArray.count - 1 {
                    formattedUrl += "&"
                }
            }
        }

        guard let url = URL(string: formattedUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if !headers.isEmpty {
            let headersArray = Array(headers)
            for (_, element) in headersArray.enumerated() {
                request.addValue(element.value, forHTTPHeaderField: element.key)
            }
        }

        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    func delete<T: Codable>(urlString: String, queryParams: [String: String] = [:], headers: [String: String] = [:]) async throws -> T {
        var formattedUrl = urlString

        if !queryParams.isEmpty {
            formattedUrl += "?"
            let queryParamsArray = Array(queryParams)
            for (index, element) in queryParamsArray.enumerated() {
                formattedUrl += "\(element.key)=\(element.value)"
                if index < queryParamsArray.count - 1 {
                    formattedUrl += "&"
                }
            }
        }

        guard let url = URL(string: formattedUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        if !headers.isEmpty {
            let headersArray = Array(headers)
            for (_, element) in headersArray.enumerated() {
                request.addValue(element.value, forHTTPHeaderField: element.key)
            }
        }

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
