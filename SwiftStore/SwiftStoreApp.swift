//
//  SwiftStoreApp.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

@main
struct SwiftStoreApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ProductListView()
                    .tabItem {
                        Label("Shop", systemImage: "bag")
                    }

                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
            }
        }
    }
}
