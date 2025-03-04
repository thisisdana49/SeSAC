//
//  ProductResponse.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

struct ProductResponse: Decodable {
    let total: Int
    let start: Int
    var items: [Product]
}

struct Product: Decodable, Hashable, Identifiable {
    let id = UUID()
    let productId: String
    let image: String
    let mallName: String
    let title: String
    let lprice: String
    var like: Bool? = false
}
