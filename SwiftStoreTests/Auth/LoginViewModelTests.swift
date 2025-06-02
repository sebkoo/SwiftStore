//
//  LoginViewModelTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class LoginViewModelTests: XCTestCase {

    func test_login_succeeds() async {
        let mockService = MockLoginService()
        mockService.shouldSucceed = true
        let viewModel = LoginViewModel(loginService: mockService)

        let expectation = XCTestExpectation(description: "Login succeeds")

        viewModel.email = "john@mail.com"
        viewModel.password = "changeme"

        viewModel.login { success in
            XCTAssertTrue(success)
            XCTAssertNil(viewModel.errorMessage)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func test_login_fails() async {
        let mockService = MockLoginService()
        mockService.shouldSucceed = false
        let viewModel = LoginViewModel(loginService: mockService)

        let expectation = XCTestExpectation(description: "Login fails")

        viewModel.email = "john@mail.com"
        viewModel.password = "wrongpass"

        viewModel.login { success in
            XCTAssertFalse(success)
            XCTAssertNotNil(viewModel.errorMessage, "Invalid credentials")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
