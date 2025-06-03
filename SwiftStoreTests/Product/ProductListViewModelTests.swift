//
//  ProductListViewModel.swift
//  SwiftStoreTests
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import XCTest
@testable import SwiftStore

@MainActor
final class ProductListViewModelTests: XCTestCase {

    // MARK: - Mock Service
    class MockServiceSuccess: ProductService {
        func fetchProductList() async throws -> [Product] {
            return [Product(id: 1, title: "Mock", price: 99.99, images: [])]
        }
    }

    class MockServiceFailure: ProductService {
        func fetchProductList() async throws -> [Product] {
            throw URLError(.notConnectedToInternet)
        }
    }

    // MARK: - Tests

    func test_loadProducts_successfully() async {
        let viewModel = ProductListViewModel(service: MockServiceSuccess())
        await viewModel.loadProducts()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Mock")
    }

    func test_loadProducts_error() async {
        let viewModel = ProductListViewModel(service: MockServiceFailure())
        await viewModel.loadProducts()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.count, 0)
    }
}
