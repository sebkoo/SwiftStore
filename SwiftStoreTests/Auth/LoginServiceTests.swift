//
//  AuthServiceTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

final class LoginServiceTests: XCTestCase {
    func test_login_succeedsWithToken() async throws {
        let mockService = SwiftLoginService(client: MockHTTPClient())
        let token = try await mockService.login(email: "john@mail.com", password: "changeme")
        XCTAssertEqual(token, "mock_token_123")
    }

    func test_refreshToken_savesNewAccessToken() async throws {
        let client = MockHTTPClient()
        let service = SwiftLoginService(client: client)

        KeychainHelper.standard.save("mock_refresh_456", service: "refresh", account: "platzi")
        let token = try await service.refreshToken()
        XCTAssertEqual(token, "mock_token_123")
    }
}
