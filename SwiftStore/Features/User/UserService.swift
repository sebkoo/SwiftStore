//
//  UserService.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

protocol UserService {
    func fetchProfile() async throws -> UserProfile
}

struct SwiftUserService: UserService {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }
    
    func fetchProfile() async throws -> UserProfile {
        try await client.get("/auth/profile")
    }
}

final class MockUserService: UserService {
    var shouldSucceed = true
    var mockProfile = UserProfile(
        id: 1,
        email: "mock@platzi.com",
        name: "Test User",
        avatar: "https://i.pravatar.cc/150?y=mock"
    )

    func fetchProfile() async throws -> UserProfile {
        if shouldSucceed {
            return mockProfile
        } else {
            throw URLError(.notConnectedToInternet)
        }
    }
}
