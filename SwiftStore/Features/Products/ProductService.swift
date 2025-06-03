//
//  ProductService.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

protocol ProductService {
    func fetchProductList() async throws -> [Product]
    func fetchProduct(id: Int) async throws -> Product
}

final class SwiftProductService: ProductService {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }

    func fetchProductList() async throws -> [Product] {
        try await client.get("/products")
    }

    func fetchProduct(id: Int) async throws -> Product {
        try await client.get("/products/\(id)")
    }
}

final class MockProductService: ProductService {
    let sampleProduct = Product(
        id: 1,
        title: "Mock T-Shirt",
        price: 29,
        images: ["https://placeimg.com/640/480/any"]
    )

    func fetchProductList() async throws -> [Product] {
        return [sampleProduct]
    }

    func fetchProduct(id: Int) async throws -> Product {
        return sampleProduct
    }
}
