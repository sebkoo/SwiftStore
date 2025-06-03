//
//  UserViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published var profile: UserProfile?
    @Published var isLoading = false
    @Published var error: String?

    private let userService: UserService

    init(userService: UserService = SwiftUserService()) {
        self.userService = userService
    }

    func fetchProfile() async {
        isLoading = true
        error = nil
        
        do {
            profile = try await userService.fetchProfile()
        } catch {
            self.error = "Failed to fetch profile"
        }
        isLoading = false
    }
}
