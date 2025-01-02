//
//  Note.swift
//  MySecondApp
//
//  Created by 조다은 on 1/2/25.
//

import Foundation


// 1. 가지고 있는 프로퍼티를 모두 초기화
// 2. 가지고 있는 프로퍼티를 옵셔널로 변경

class Monster {
    let clothes: String
    let speed: Int
    let power: Int
    let experience: Int
    
    init(clothes: String, speed: Int, power: Int, experience: Int) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.experience = experience
    }
    
//    func initializer(clothes: String, speed: Int, power: Int, experience: Int) {
//        self.clothes = clothes
//        self.speed = speed
//        self.power = power
//        self.experience = experience
//    }
}

class BossMonster: Monster {
    
}

class SuperMonster: BossMonster {
    // 이런 식으로 계속해서 상속 받을 수 있고, 그러면 신경 써야할 요소들이 많기 때문에 필수적으로 초기화 해주는 것
}

struct MonsterStruct {
    let clothes: String
    let speed: Int
    let power: Int
    let experience: Int
    
    // init이 없더라고 기본으로 제공해주고 있음 -> Memberwise Initializer
}
