//
//  UserServiceTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

final class UserServiceTests: XCTestCase {

    func test_fetchProfile_success_returnsUserProfile() async throws {
        // Given
        let mockProfile = UserProfile(
            id: 1,
            email: "john@mail.com",
            name: "John",
            avatar: "avatar.png"
        )
        let mockData = try! JSONEncoder().encode(mockProfile)

        let mockClient = MockHTTPClient()
        mockClient.mockData = mockData

        let service = SwiftUserService(client: mockClient)

        // When
        let profile = try await service.fetchProfile()

        // Then
        XCTAssertEqual(profile, mockProfile)
    }

    func test_fetchProfile_failure_throwsError() async {
        // Given
        let mockClient = MockHTTPClient()
        mockClient.shouldFail = true
        let service = SwiftUserService(client: mockClient)

        // When & Then
        do {
            _ = try await service.fetchProfile()
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
