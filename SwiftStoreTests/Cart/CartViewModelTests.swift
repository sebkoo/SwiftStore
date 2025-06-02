//
//  CartViewModelTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class CartViewModelTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        CartManager.shared.clear()
    }

    func test_cartViewModel_initializesWithItems() {
        let product = Product(id: 10, title: "Test", price: 20, images: [])
        CartManager.shared.add(product)
        CartManager.shared.add(product)

        let viewModel = CartViewModel()

        XCTAssertEqual(viewModel.items.count, 1)
        XCTAssertEqual(viewModel.items.first?.quantity, 2)
        XCTAssertEqual(viewModel.totalPrice, 40.0)
    }

    func test_clearCart_emptiesCart() {
        let product = Product(id: 5, title: "Clear Me", price: 15, images: [])
        CartManager.shared.add(product)

        let viewModel = CartViewModel()
        viewModel.clearCart()

        XCTAssertEqual(viewModel.items.count, 0)
        XCTAssertEqual(viewModel.totalPrice, 0.0)
    }
}
