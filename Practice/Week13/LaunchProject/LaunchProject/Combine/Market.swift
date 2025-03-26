//
//  Market.swift
//  LaunchProject
//
//  Created by 조다은 on 3/26/25.
//

import Foundation

struct Market: Codable, Hashable {
    let market: String
    let koreanName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]
