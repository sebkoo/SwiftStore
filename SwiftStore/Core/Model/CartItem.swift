//
//  CartItem.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

struct CartItem: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int

    init(product: Product, quantity: Int = 1) {
        self.id = product.id
        self.title = product.title
        self.price = product.price
        self.quantity = quantity
    }

    var totalPrice: Double {
        price * Double(quantity)
    }
}
