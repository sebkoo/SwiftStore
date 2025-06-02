//
//  LoginViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?

    private let loginService: LoginService

    init(loginService: LoginService = SwiftLoginService()) {
        self.loginService = loginService
    }

    func login(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                _ = try await loginService.login(email: email, password: password)
                completion(true)
            } catch {
                errorMessage = "Invalid credentials"
                completion(false)
            }
        }
    }
}
