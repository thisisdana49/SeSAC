//: [Previous](@previous)

import Foundation

// Hue 클래스는 BranFood 나 DenFood 같은 구현체에 의존하고 있지 않다.
// 대신 Hue 클래스는 식당 이라는 프로토콜에 의존을 하고 있다.
// 식당 이라는 프로토콜을 채택하고 있는 어떤 구체 타입(Concrete Type)들을 다 적용할 수 있다

// 추상화
protocol 식당 {
    func 점심() -> String
}

class Hue {
    var food: 식당
    
    init(food: 식당) {
        self.food = food
    }
    
    func 점심() -> String {
        food.점심()
    }
}
// 구체 타입(Concrete Type)
class BranFood: 식당 {
    private let 주인장 = Bran()
    
    func 점심() -> String {
        return 주인장.국밥() + 주인장.평양냉면() + 주인장.꿔바로우()
    }
}
// 구체 타입(Concrete Type)
class DenFood: 식당 {
    private let 주인장 = Bran()
    
    func 점심() -> String {
        return "오직 샌드위치"
    }
}

class Bran {
    func 평양냉면() -> String {
        return "맛있는 냉면"
    }
    
    func 국밥() -> String {
        return "맛있는 국밥"
    }
    
    func 꿔바로우() -> String {
        return "맛있는 꿔바로우"
    }
}

/*
 Hue 클래스는 DenFood 음식점을 이니셜라이저 시점에 주입을 받고 있다.
 Hue 클래스는 DenFood를 상속받는 어떤 클래스의 인스턴스로도 생성이 가능하다.
 DenFood를 init 타입으로 지정하는 것
 => Hue 클래스에 무엇이 들어올지는 모르지만 사용은 할 수 있다.
 => 즉, 어떤 클래스가 들어올지는 모르지만 동작은 시킬 수 있다.
 => 의존성 주입(Dependency Injection)
 => DI를 통해서 객체의 생성과 사용을 분리한다.
 
 => 여전히 하위 모듈의 변화가 상위 모듈에 영향을 미치고 있기 때문에
 => 구현체에 의존하지 않고 추상화에 의존하도록 변경하고 싶음.
 => DIP를 준수해보자!
 
 DI 를 적용했다고 하여, DIP 를 준수하고 있는 것은 아니다.
 DIP 를 구현하는 기법 중 하나로 DI 를 사용할 수 있다.
 
 의존 관계 역전 원칙
 Dependency Inversion Principle (SOLID D)
 */

let food = BranFood()
let person = Hue(food: food)

person.점심()

//: [Next](@next)
