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
}
