//
//  Lotto.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import Foundation

struct Lotto: Decodable {
    let drwNo: Int
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    var drwtNums: [Int] {
        return [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo]
    }
    
//    enum CodingKeys: String, CodingKey {
//        case bnusNo = "drwtNo7"
//        case drwNo, drwNoDate, drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6
//    }
}
