//
//  SessionManagerTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class SessionManagerTests: XCTestCase {

    func test_init_withToken_setsIsLoggedInTrue() {
        let mockService = MockLoginService()
        mockService.mockToken = nil
        let manager = SessionManager(loginService: mockService)

        XCTAssertFalse(manager.isLoggedIn)
    }

    func test_init_whenTokenExists_setsIsLoggedInToTrue() {
        let mockService = MockLoginService()
        mockService.mockToken = "token"
        let manager = SessionManager(loginService: mockService)
        
        XCTAssertTrue(manager.isLoggedIn)
    }

    func test_loginSucceeded_setsIsLoggedInToTrue() {
        let mockService = MockLoginService()
        let manager = SessionManager(loginService: mockService)

        manager.loginSucceeded()

        XCTAssertTrue(manager.isLoggedIn)
    }

    func test_logout_setsIsLoggedInToFalse() {
        let mockService = MockLoginService()
        let manager = SessionManager(loginService: mockService)
        
        manager.loginSucceeded()    // start logged in
        manager.logout()
        
        XCTAssertFalse(manager.isLoggedIn)
    }
}
