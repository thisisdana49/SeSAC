//
//  Shop.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

struct Item: Decodable {
    let total: Int
    let start: Int
    let items: [ItemDetail]
}

struct ItemDetail: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lprice: String
}
