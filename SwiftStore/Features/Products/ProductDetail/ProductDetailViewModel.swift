//
//  ProductDetailViewModel.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    let product: Product

    init(product: Product) {
        self.product = product
    }

    var title: String { product.title }
    var price: String { String(format: "$%.2f", product.price) }
    var imageURL: URL? {
        URL(string: product.images.first ?? "")
    }
}
