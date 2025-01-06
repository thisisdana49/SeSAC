//: [Previous](@previous)

import UIKit


// 연산 프로퍼티
class BMI {
    var weight: Double
    var height: Double
    
    // class: 그래 내가 할게... 내 문제니까.
    var bmiResult: String {
        // 다른 저장 프로퍼티의 값을 통해 연산을 함
//        get {
            let bmiValue = height / (weight * weight)
            let bmiResult = bmiValue < 18.5 ? "저체중" : "정상 이상"
            let result = "BMI 지수는 \(bmiValue)는 \(bmiResult)입니도."
            return result
//        } get만 쓴다면 생략이 가능한.
    }
    
    init(weight: Double, height: Double) {
        self.weight = weight
        self.height = height
    }
}

let bmi = BMI(weight: 40, height: 1.5)

// BMI 지수 계싼
let bmiValue = bmi.height / (bmi.weight * bmi.weight)

// BMI 결과
let bmiResult = bmiValue < 18.5 ? "저체중" : "정상 이상"

let result = "BMI 지수는 \(bmiValue)는 \(bmiResult)입니도."

// If self == VC라면?
// VC: "왜 내가 계산해야해? 니꺼잖아?
// class: ㅇㅋ
bmi.bmiResult


// 선언과 초기화를 따로 할 수 있다.
var greeting: String

// 그러나 초기화(초기값)을 해야 변수르 쓸 수 있다!
greeting = "Hello"
greeting.append(contentsOf: "World!")


class Movie {
    let title: String
    let runtime: Int
    lazy var video = Video() //지연 저장 프로퍼티
    
    init(title: String, runtime: Int) {
        self.title = title
        self.runtime = runtime
        print("Movie init")
    }
}

class Video {
    var file = UIImage(systemName: "star") // 2gb
    
    init() {
        print("Video Init")
    }
}

var media = Movie(title: "그해, 우리는", runtime: 134)
media.video
// 초기화 시점을 미뤄준다.
// lazy는 let으로 같이 쓰지 못함(컴파일 오류). var로 써야한다. Why?
// static은 lazy하게 동작한다? WhY? 지연 저장이 된다?... 더 공부해보기 :3

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
