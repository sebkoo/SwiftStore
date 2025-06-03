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

    var cart: CartManager!
    var product: Product!

    override func setUpWithError() throws {
        super.setUp()
        cart = CartManager.shared
        cart.clear()    // reset
        product = Product(id: 1, title: "Test Product", price: 9.99, images: [])
    }

    override func tearDown() {
        cart.clear()
        cart = nil
        product = nil
        super.tearDown()
    }

    func test_addProduct_increasesCart() {
        cart.add(product)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 1)
    }

    func test_addSameProduct_increasesQuantity() {
        cart.add(product)
        cart.add(product)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 2)
    }

    func test_increasesProduct() {
        cart.add(product)
        let item = cart.items.first!
        cart.increaseQuantity(item)

        XCTAssertEqual(cart.items.first?.quantity, 2)
    }

    func test_decreasesProduct_reducesQuantity() {
        cart.add(product)
        cart.add(product)
        let item = cart.items.first!
        cart.decreaseQuantity(item)

        XCTAssertEqual(cart.items.first?.quantity, 1)
    }

    func test_decreasesProduct_atZero() {
        cart.add(product)
        let item = cart.items.first!
        cart.decreaseQuantity(item)

        XCTAssertTrue(cart.items.isEmpty)
    }

    func test_removeProduct() {
        cart.add(product)
        cart.remove(product)

        XCTAssertTrue(cart.items.isEmpty)
    }

    func test_clearCart_emptiesAllItems() {
        cart.add(product)
        cart.clear()

        XCTAssertTrue(cart.items.isEmpty)
    }

    func test_persistence() {
        let product = Product(id: 4, title: "Persist", price: 3.0, images: [])
        cart.add(product)

        let newCart = CartManager.shared
        XCTAssertFalse(newCart.items.isEmpty)
    }

    func test_calculateTotalPrice() {
        cart.add(product)
        cart.add(product)
        let total = cart.items.map { $0.totalPrice }.reduce(0, +)

        XCTAssertEqual(total, 19.98, accuracy: 0.01)
    }
}
