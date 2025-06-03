//
//  HTTPClient.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

class HTTPClient {
    private let baseURL = URL(string: "https://api.escuelajs.co/api/v1")!

    func get<T: Decodable>(_ endpoint: String) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await send(request)
    }

    func post<T: Decodable>(_ endpoint: String, body: [String: Any]) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        return try await send(request)
    }

    private func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        var request = request

        if let token = KeychainHelper.standard.read(service: "token", account: "platzi") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard
            let httpResponse = response as? HTTPURLResponse,
                (200..<300) ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw URLError(.badServerResponse, userInfo: ["message": errorMessage])
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

final class MockHTTPClient: HTTPClient {
    override func post<T: Decodable>(_ endpoint: String, body: [String: Any]) async throws -> T {
        let mockResponse = LoginResponse(access_token: "mock_token_123", refresh_token: "mock_refresh_456")
        return mockResponse as! T
    }
}
