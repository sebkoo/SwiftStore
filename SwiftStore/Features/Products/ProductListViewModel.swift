//
//  ProductListViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: ProductService

    init(service: ProductService = SwiftProductService()) {
        self.service = service
    }

    func loadProducts() async {
        isLoading = true
        do {
            products = try await service.fetchProductList()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
