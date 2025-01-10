//
//  Tamagotchi.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/10/25.
//

import UIKit

struct Tamagotchi: Codable {
    static let identifier = "Tamagotchi"
    var bossName: String = "대장"
    var level: Level = .levelOne {
        didSet {
            image = "2-\(level.rawValue)"
        }
    }
    var mealCount: Int = 0 {
        didSet { computedLevel() }
    }
    var waterCount: Int = 0 {
        didSet { computedLevel() }
    }
    var image: String = "2-1"
    
    mutating func performAcion(_ action: Action, count: Int = 1) {
        switch action {
        case .giveMeal:
            mealCount += count
        case .giveWater:
            waterCount += count
        }
    }
    
    mutating func computedLevel() {
        let mealRatio = Double(mealCount / 5)
        let waterRatio = Double(waterCount / 2)
        let levelValue = Int(floor((mealRatio + waterRatio) * 0.1))
        let boundedLevel = min(max(levelValue, 1), Level.allCases.count)
        level = Level(rawValue: boundedLevel) ?? .levelOne
    }
    
    enum Level: Int, Codable, CaseIterable {
        case levelOne = 1
        case levelTwo
        case levelThree
        case levelFour
        case levelFive
        case levelSix
        case levelSeven
        case levelEight
        case levelNine
        case levelTen
        
        var badge: String {
            switch self {
            case .levelOne:     return "아직 새싹 다마고치"
            case .levelTwo:     return "떡잎이 남다른 다마고치"
            case .levelThree:   return "장래유망 다마고치"
            case .levelFour:    return "무럭무럭 다마고치"
            case .levelFive:    return "까꿍 다마고치"
            case .levelSix:     return "무르익은 다마고치"
            case .levelSeven:   return "예쁘게 자란 다마고치"
            case .levelEight:   return "곧 피어날 다마고치"
            case .levelNine:    return "활짝 핀 다마고치"
            case .levelTen:     return "활짝 핀 다마고치"
            }
        }
    }
}

enum Action {
    case giveMeal
    case giveWater
}
