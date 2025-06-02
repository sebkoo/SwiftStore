//
//  MainView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct MainView: View {
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
        }
    }
}

#Preview {
    MainView()
}
