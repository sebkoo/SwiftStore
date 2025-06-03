//
//  FavoriteItem.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import Foundation

struct FavoriteItem: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let image: String
}
