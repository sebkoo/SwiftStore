//
//  ProductService.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

protocol ProductService {
    func fetchProducts() async throws -> [Product]
}

final class SwiftProductService: ProductService {
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
