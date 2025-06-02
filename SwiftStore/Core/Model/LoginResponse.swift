//
//  Login.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import Foundation

struct LoginResponse: Decodable {
    let access_token: String
    let refresh_token: String
}
