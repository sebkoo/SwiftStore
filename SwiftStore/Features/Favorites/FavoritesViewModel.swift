//
//  FavoritesViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var items: [FavoriteItem] = []

    private let manager = FavoritesManager.shared

    init() {
        self.items = manager.items
    }

    private func observeFavorites() {
        Task {
            for await updatedItems in manager.$items.values {
                self.items = updatedItems
            }
        }
    }
}
