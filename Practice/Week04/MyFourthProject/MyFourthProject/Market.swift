//
//  Market.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

struct Market: Decodable {
    let market: String
    let name: String?
    let koreanName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market, name
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
