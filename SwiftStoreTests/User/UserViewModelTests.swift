//
//  UserViewModelTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class UserViewModelTests: XCTestCase {
    func test_fetchProfile_success_setsUser() async throws {
        let mockService = MockUserService()
        let viewModel = UserViewModel(userService: mockService)

        await viewModel.fetchProfile()

        XCTAssertEqual(viewModel.profile, mockService.mockProfile)
        XCTAssertNil(viewModel.error)
    }

    func test_fetchProfile_failure_setsError() async throws {
        let mockService = MockUserService()
        mockService.shouldSucceed = false
        let viewModel = UserViewModel(userService: mockService)

        await viewModel.fetchProfile()

        XCTAssertNil(viewModel.profile)
        XCTAssertEqual(viewModel.error, "Failed to fetch profile")
    }
}
