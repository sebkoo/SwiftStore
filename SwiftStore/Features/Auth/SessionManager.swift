//
//  SessionManager.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

@MainActor
final class SessionManager: ObservableObject {
    static let shared = SessionManager()    // for app use

    @Published var isLoggedIn: Bool = false

    private let loginService: LoginService

    init(loginService: LoginService = SwiftLoginService()) {
        self.loginService = loginService
        Task { await refreshSessionIfNeeded() }
    }

    func logout() {
        loginService.logout()
        isLoggedIn = false
    }

    func loginSucceeded() {
        isLoggedIn = true
    }

    func refreshSessionIfNeeded() async {
        if loginService.currentToken() != nil {
            self.isLoggedIn = true
            return
        }

        do {
            _ = try await loginService.refreshToken()
            self.isLoggedIn = true
        } catch {
            self.isLoggedIn = false
        }
    }
}
