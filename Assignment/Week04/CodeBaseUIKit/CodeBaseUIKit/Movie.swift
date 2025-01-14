//
//  Movie.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import Foundation

struct Movies: Codable {
    let boxOfficeResult: BoxOfficResult
}

struct BoxOfficResult: Codable {
    let dailyBoxOfficeList: [dailyBoxOfficeList]
}

struct dailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
}
