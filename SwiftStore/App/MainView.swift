//
//  MainView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var session = SessionManager.shared

    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Shop", systemImage: "bag")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }

            Button("Logout") {
                session.logout()
            }
            .tabItem {
                Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
            }
        }
    }
}

#Preview {
    MainView()
}
