//
//  Emotion.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 1/7/25.
//

import Foundation

struct Emotion: Codable {
    let name: String
    var degree: Int = 0
    
    var info: String {
        get {
            return "\(name) \(degree)"
        }
    }
}

struct EmotionInfo {
    let emotions: [Emotion] = [
        Emotion(name: "행복해"),
        Emotion(name: "사랑해"),
        Emotion(name: "좋아해"),
        Emotion(name: "화가나"),
        Emotion(name: "꿀꿀해"),
        Emotion(name: "지루해"),
        Emotion(name: "무서워"),
        Emotion(name: "속상해"),
        Emotion(name: "눈물나"),
    ]
}
