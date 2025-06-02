//
//  SwiftStoreApp.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

@main
struct SwiftStoreApp: App {
    @StateObject private var session = SessionManager.shared

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
