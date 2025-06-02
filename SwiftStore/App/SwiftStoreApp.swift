//
//  SwiftStoreApp.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

@main
struct SwiftStoreApp: App {
    let loginService = SwiftLoginService()

    var body: some Scene {
        WindowGroup {
            if loginService.currentToken() != nil {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
