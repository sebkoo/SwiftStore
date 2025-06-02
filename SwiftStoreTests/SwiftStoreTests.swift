//
//  SwiftStoreTests.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import XCTest
@testable import SwiftStore

final class ProductServiceTests: XCTestCase {
    func test_fetchProducts_returnsProductArray() async throws {
        let service = ProductService()
        let products = try await service.fetchProducts()
        XCTAssertFalse(products.isEmpty)
    }
}
