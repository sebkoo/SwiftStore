//
//  ProductDetailViewModelTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import XCTest
@testable import SwiftStore

final class ProductDetailViewModelTests: XCTestCase {
    func test_productDetail_hasCorrectTitle() {
        let product = Product(id: 1, title: "Test Product", price: 99.99, images: ["https://via.placeholder.com/150"])
        let viewModel = ProductDetailViewModel(product: product)
        XCTAssertEqual(viewModel.title, "Test Product")
    }
}
