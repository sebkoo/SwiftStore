//
//  CartViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation
import Combine

@MainActor
final class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var totalPrice: Double = 0.0

    private var cart = CartManager.shared
    private var cancellables: Set<AnyCancellable> = []

    init() { observe() }

    func observe() {
        cart = CartManager.shared
        items = cart.items
        totalPrice = cart.items.map { $0.totalPrice }.reduce(0, +)

        cart.$items
            .sink { [weak self] updated in
                self?.items = updated
                self?.totalPrice = updated.map { $0.totalPrice }.reduce(0, +)
            }
            .store(in: &cancellables)
    }

    func increase(_ item: CartItem) {
        cart.increaseQuantity(item)
    }

    func decrease(_ item: CartItem) {
        cart.decreaseQuantity(item)
    }

    func clearCart() {
        cart.clear()
    }

    func remove(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            cart.remove(Product(id: item.id, title: item.title, price: item.price, images: []))
        }
    }
}
