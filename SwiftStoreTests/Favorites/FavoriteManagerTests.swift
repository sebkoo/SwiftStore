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
    let testProd = Product(id: 1, title: "Test", price: 10.0, images: [""])

    override func setUp() {
        super.setUp()
        manager = FavoritesManager.shared
        manager.clear() // Clear state
    }

    override func tearDown() {
        manager.clear()
        super.tearDown()
    }

    func test_addFavorite() {
        XCTAssertFalse(manager.contains(testProd))
        manager.add(testProd)
        XCTAssertTrue(manager.contains(testProd))
        XCTAssertEqual(manager.items.count, 1)
    }

    func test_removeFavorite() {
        manager.add(testProd)
        manager.remove(testProd)
        XCTAssertFalse(manager.contains(testProd))
        XCTAssertEqual(manager.items.count, 0)
    }

    func test_toggleFavorite() {
        manager.toggle(testProd)
        XCTAssertTrue(manager.contains(testProd))

        manager.toggle(testProd)
        XCTAssertFalse(manager.contains(testProd))
    }
}
