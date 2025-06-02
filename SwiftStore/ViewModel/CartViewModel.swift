//
//  CartViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var totalPrice: Double = 0

    private var cartManager = CartManager.shared

    init() {
        self.items = cartManager.items
        self.totalPrice = cartManager.items.reduce(0) { $0 + $1.totalPrice }

        Task {
            for await _ in cartManager.$items.values {
                self.items = cartManager.items
                self.totalPrice = cartManager.items.reduce(0) { $0 + $1.totalPrice }
            }
        }
    }

    func clearCart() {
        cartManager.clear()
        items = cartManager.items
        totalPrice = items.reduce(0) { $0 + $1.totalPrice }
    }
}
