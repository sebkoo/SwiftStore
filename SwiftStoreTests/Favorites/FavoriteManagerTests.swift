//
//  FavoriteManagerTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class FavoriteManagerTests: XCTestCase {
    var manager: FavoritesManager!
    let sampleProduct = Product(id: 1, title: "Test", price: 10.0, images: [""])

    override func setUp() async throws {
        manager = FavoritesManager.shared
        manager.clear() // Clear state
    }

    func test_addFavorite() {
        manager.add(sampleProduct)
        XCTAssertEqual(manager.items.count, 1)
    }

    func test_removeFavorite() {
        manager.add(sampleProduct)
        manager.remove(sampleProduct)
        XCTAssertTrue(manager.items.isEmpty)
    }

    func test_toggleFavorite() {
        manager.toggle(sampleProduct)
        XCTAssertTrue(manager.contains(sampleProduct))

        manager.toggle(sampleProduct)
        XCTAssertFalse(manager.contains(sampleProduct))
    }
}
