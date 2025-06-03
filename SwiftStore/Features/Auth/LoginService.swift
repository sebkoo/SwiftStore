//
//  LoginService.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

protocol LoginService {
    func login(email: String, password: String) async throws -> String
    func logout()
    func currentToken() -> String?
    func refreshToken() async throws -> String
}

struct SwiftLoginService: LoginService {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }

    func login(email: String, password: String) async throws -> String {
        let body: [String: Any] = ["email": email, "password": password]
        let response: LoginResponse = try await client.post("/auth/login", body: body)
        saveTokens(response)
        return response.access_token
    }

    func logout() {
        KeychainHelper.standard.delete(service: "token", account: "platzi")
        KeychainHelper.standard.delete(service: "refresh_token", account: "platzi")
    }

    func currentToken() -> String? {
        KeychainHelper.standard.read(service: "token", account: "platzi")
    }

    func refreshToken() async throws -> String {
        guard let token = currentRefreshToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        let body: [String: Any] = ["refreshToken": token]
        let response: LoginResponse = try await client.post("/auth/refresh-token", body: body)
        saveTokens(response)
        return response.access_token
    }

    private func currentRefreshToken() -> String? {
        KeychainHelper.standard.read(service: "refresh_token", account: "platzi")
    }

    private func saveTokens(_ response: LoginResponse) {
        KeychainHelper.standard.save(response.access_token, service: "token", account: "platzi")
        KeychainHelper.standard.save(response.refresh_token, service: "refresh_token", account: "platzi")
    }
}

final class MockLoginService: LoginService {
    var shouldSucceed: Bool = true
    var mockToken: String? = "mock_token"
    var mockRefreshToken: String? = "mock_refresh_token"

    func login(email: String, password: String) async throws -> String {
        if shouldSucceed {
            return "mock_token"
        } else {
            throw URLError(.userAuthenticationRequired)
        }
    }

    func logout() {
        mockToken = nil
        mockRefreshToken = nil
    }

    func currentToken() -> String? {
        return mockToken
    }

    func refreshToken() async throws -> String {
        if shouldSucceed, let refreshedToken = mockToken {
            return refreshedToken
        } else {
            throw URLError(.userAuthenticationRequired)
        }
    }
}
