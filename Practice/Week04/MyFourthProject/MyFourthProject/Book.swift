//
//  Book.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

struct Book: Decodable {
    let documents: [BookDetail]
    let meta: Meta
}

struct BookDetail: Decodable {
    let contents: String
    let price: Int
    let title: String 
    let thumbnail: String
}

struct Meta: Decodable {
    let isEnd: Bool
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case totalCount = "total_count"
    }
}
