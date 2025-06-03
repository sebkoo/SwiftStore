//
//  Product.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let images: [String]
}

extension Product {
    static func fromFavorite(_ fav: FavoriteItem) -> Product? {
        Product(id: fav.id,
                title: fav.title,
                price: fav.price,
                images: [fav.image])
    }
}
