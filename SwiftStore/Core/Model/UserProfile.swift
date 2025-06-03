//
//  UserProfile.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

struct UserProfile: Codable, Equatable, Identifiable {
    let id: Int
    let email: String
    let name: String
    let avatar: String
}
