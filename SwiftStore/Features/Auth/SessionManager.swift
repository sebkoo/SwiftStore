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
        self.isLoggedIn = loginService.currentToken() != nil
    }

    func logout() {
        loginService.logout()
        isLoggedIn = false
    }

    func loginSucceeded() {
        isLoggedIn = true
    }
}
