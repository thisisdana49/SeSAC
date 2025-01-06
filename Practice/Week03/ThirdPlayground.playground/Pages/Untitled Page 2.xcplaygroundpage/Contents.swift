//: [Previous](@previous)

import Foundation


// 선언과 초기화를 따로 할 수 있다.
var greeting: String

// 그러나 초기화(초기값)을 해야 변수르 쓸 수 있다!
greeting = "Hello"
greeting.append(contentsOf: "World!")

// class도 동일하다.
class Monster {
    static let game = "Squard Busters" // 타입 프로퍼티 - 인스턴싱 없이도 쓸 수 있는 프로퍼티
    
    let clothes: String // 인스턴스 프로퍼티 - 어디 한 곳에 담기고(인스턴싱) 난 뒤에 쓸 수 있기 때문에.
    let speed: Int
    let exp: Int
    
    static func ment() { // 타입 메서드
        print("아아아아악~")
    }
    
    func attack() { // 인스턴스 메서드 - 어디 한 곳에 담기고(인스턴싱) 난 뒤에 쓸 수 있기 때문에.
        print("공격!")
    }
    
    init(clothes: String, speed: Int, exp: Int) {
        self.clothes = clothes
        self.speed = speed
        self.exp = exp
    }
}

// class 내 모든 변수가 초기화가 되어 있어야 한다.
// class 내 모든 프로퍼티가 초기값이 지정되어 있어야 한다.
// 인스턴스가 생성되면, 프로퍼티/메서드에 접근할 수 있음. => 인스턴스
// 인스턴스가 생성되지 않고도 접근할 수 있는 프로퍼티/메서드가 있음 => 타입
var easy: Monster? = Monster(clothes: "Red", speed: 1, exp: 1)
easy?.clothes
easy?.speed
easy?.exp
easy?.attack()

easy = nil

var hard: Monster? = Monster(clothes: "Yellow", speed: 100, exp: 100)
hard?.clothes
hard?.speed
hard?.exp
hard?.attack()

hard = nil

hard?.clothes

// 인스턴스끼리 하나의 공간을 공유
// 아무리 많이 생겨도 하나
// 또한 호출하지 않으면 공간을 차지 않음
// 그러나 한 번 호출하면 끝날때까지 영원히 메모리 공간을 차ㅣㅈ
// 그래서 잘 사용해야한다...!
// Monster.self.game
Monster.game

//: [Next](@next)
