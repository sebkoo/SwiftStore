//
//  CartItemTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import XCTest
@testable import SwiftStore

final class CartItemTests: XCTestCase {

    func test_initializeCartItem_defaultQuantity() {
        let product = Product(id: 1, title: "Test", price: 10.0, images: [])
        let item = CartItem(product: product)

        XCTAssertEqual(item.id, product.id)
        XCTAssertEqual(item.title, product.title)
        XCTAssertEqual(item.price, product.price)
        XCTAssertEqual(item.quantity, 1)
    }

    func test_initializeCartItem_customQuantity() {
        let product = Product(id: 2, title: "Shirt", price: 15.5, images: [])
        let item = CartItem(product: product, quantity: 3)

        XCTAssertEqual(item.quantity, 3)
    }

    func test_calculateTotalPrice() {
        let product = Product(id: 3, title: "Sneakers", price: 50.0, images: [])
        let item = CartItem(product: product, quantity: 2)

        XCTAssertEqual(item.totalPrice, 100.0)
    }

    func test_cartItemEquality() {
        let product1 = Product(id: 4, title: "Cap", price: 9.0, images: [])
        let product2 = Product(id: 4, title: "Cap", price: 9.0, images: [])
        let item1 = CartItem(product: product1, quantity: 2)
        let item2 = CartItem(product: product2, quantity: 2)

        XCTAssertEqual(item1, item2)
    }

    func test_cartItemInequality() {
        let product1 = Product(id: 5, title: "Socks", price: 5.0, images: [])
        let product2 = Product(id: 6, title: "Socks", price: 5.0, images: [])
        let item1 = CartItem(product: product1, quantity: 1)
        let item2 = CartItem(product: product2, quantity: 1)

        XCTAssertNotEqual(item1, item2)
    }
}
