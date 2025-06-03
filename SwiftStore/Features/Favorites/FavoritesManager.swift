//
//  FavoritesManager.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import Foundation

@MainActor
final class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    @Published private(set) var items: [FavoriteItem] = [] {
        didSet { saveFavorites() }
    }

    private let key = "favorite_product_ids"

    private init() { loadFavorites() }

    func add(_ product: Product) {
        guard !items.contains(where: { $0.id == product.id }) else { return }
        let item = FavoriteItem(
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.images.first ?? ""
        )
        items.append(item)
    }

    func remove(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    func toggle(_ product: Product) {
        items.contains(where: { $0.id == product.id })
            ? remove(product)
            : add(product)
    }

    func contains(_ product: Product) -> Bool {
        items.contains { $0.id == product.id }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadFavorites() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let savedItems = try? JSONDecoder().decode([FavoriteItem].self, from: data)
        else { return }
        items = savedItems
    }

    #if DEBUG
    func clear() {
        items = []
        UserDefaults.standard.removeObject(forKey: key)
    }
    #endif
}
