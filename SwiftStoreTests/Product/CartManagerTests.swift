//
//  CartManagerTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class CartManagerTests: XCTestCase {
    func test_addProduct_addsToCart() {
        let manager = CartManager.shared
        manager.clear() // reset cart

        let product = Product(id: 1, title: "Test", price: 10, images: [])
        manager.add(product)

        XCTAssertEqual(manager.items.count, 1)
        XCTAssertEqual(manager.items.first?.quantity, 1)
    }

    func test_addSameProduct_increasesQuantity() {
        let manager = CartManager.shared
        manager.clear()

        let product = Product(id: 1, title: "Test", price: 10, images: [])
        manager.add(product)
        manager.add(product)

        XCTAssertEqual(manager.items.count, 1)
        XCTAssertEqual(manager.items.first?.quantity, 2)
    }
}
