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

    private var cart = CartManager.shared

    init() {
        self.items = cart.items
        self.totalPrice = cart.items.reduce(0) { $0 + $1.totalPrice }

        Task {
            for await _ in cart.$items.values {
                self.items = cart.items
                self.totalPrice = cart.items.reduce(0) { $0 + $1.totalPrice }
            }
        }
    }


    func clearCart() {
        cart.clear()
        items = cart.items
        totalPrice = items.reduce(0) { $0 + $1.totalPrice }
    }
}
