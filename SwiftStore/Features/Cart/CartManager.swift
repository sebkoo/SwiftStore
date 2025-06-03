//
//  CartViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

@MainActor
final class CartManager: ObservableObject {
    static let shared = CartManager()

    @Published private(set) var items: [CartItem] = [] {
        didSet { saveCart() }
    }

    private let cartKey = "cart_items"

    private init() { loadCart() }

    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            var currentItem = items[index]
            items[index] = CartItem(product: product, quantity: currentItem.quantity + 1)
        } else {
            items.append(CartItem(product: product))
        }
    }

    func remove(_ product: Product) {
        items.removeAll() { $0.id == product.id }
    }

    func clear() {
        items = []
        UserDefaults.standard.removeObject(forKey: cartKey)
    }

    private func saveCart() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: cartKey)
    }

    private func loadCart() {
        guard
            let data = UserDefaults.standard.data(forKey: cartKey),
            let savedItems = try? JSONDecoder().decode([CartItem].self, from: data)
        else { return }
        items = savedItems
    }
}
