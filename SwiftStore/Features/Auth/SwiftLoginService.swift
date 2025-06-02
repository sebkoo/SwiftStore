//
//  LoginService.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

protocol LoginService {
    func login(email: String, password: String) async throws -> String
}

struct SwiftLoginService: LoginService {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }

    func login(email: String, password: String) async throws -> String {
        let body: [String: Any] = ["email": email, "password": password]
        let response: LoginResponse = try await client.post("/auth/login", body: body)
        KeychainHelper.standard.save(response.access_token, service: "token", account: "platzi")
        return response.access_token
    }

    func logout() {
        KeychainHelper.standard.delete(service: "token", account: "platzi")
    }

    func currentToken() -> String? {
        KeychainHelper.standard.read(service: "token", account: "platzi")
    }
}

final class MockLoginService: LoginService {
    var shouldSucceed: Bool = true

    func login(email: String, password: String) async throws -> String {
        if shouldSucceed {
            return "mock_token"
        } else {
            throw URLError(.userAuthenticationRequired)
        }
    }
}
