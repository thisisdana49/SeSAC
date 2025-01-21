//
//  RandomPhoto.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/21/25.
//

import Foundation

struct RandomPhoto: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: RandomPhotoURL
}

struct RandomPhotoURL: Decodable {
    let thumb: String
}
