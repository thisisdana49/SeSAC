//
//  Models.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/14/25.
//

import Foundation

struct Dog: Codable {
    let message: String
    let status: String
}

struct Lotto: Codable {
    let drwNoDate: String
    let firstWinamnt: Int
}

struct User: Codable {
    let results: [UserDetail]
//    let info: Info
}

struct UserDetail: Codable {
    let name: Name
}

struct Name: Codable {
    let last: String
}
