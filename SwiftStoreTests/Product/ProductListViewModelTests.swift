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

    private var viewModel: ProductListViewModel!
    private var mockService: MockProductService!

    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        viewModel = ProductListViewModel(service: mockService)
    }

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

    func test_loadingStateChanges() async {
        let loading = XCTestExpectation(description: "ViewModel started loading")
        let loaded = XCTestExpectation(description: "ViewModel finished loading")

        // Observe changes to `isLoading`
        let cancellable = viewModel.$isLoading.sink { isLoading in
            isLoading ? loading.fulfill() : loaded.fulfill()
        }

        await viewModel.loadProducts()

        await fulfillment(of: [loading, loaded], timeout: 2)

        cancellable.cancel()
    }
}
