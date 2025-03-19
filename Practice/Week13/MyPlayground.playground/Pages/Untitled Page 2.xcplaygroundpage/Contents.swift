//: [Previous](@previous)

import Foundation

/*
 Hue 클래스는 BranFood에, BrandFood는 Bran 클래스에 의존하고 있는 코드
 BranFood에서 뭔가 변화가 일어나면, Hue 클래스에 영향을 미친다.
 
 A가 B를 의존한다.
 B에서 변화가 발생했을 때, A에 영향을 미친다.
 
 => Dependency
 
 Hue - 상위 모듈, BranFood - 하위 모듈
 하위 모듈에서의 코드 변화가 사위 모듈에 영향을 미친다
 
 => 하위 모듈에서의 코드 변화가 상위 모듈에 영향을 미치지 않도록 코드를 구성해볼 수 없을까?
 => 식당(BranFood)이 바뀌거나 주인장(Bran)이 바뀌더라도 휴님의 코드에 영향이 없으려면 어떻게 개선할 수 있을까?
 => 해결: 구현체가 아닌 추상화(protocol, Interface)에 의존한다.
 => 인터페이스로 의존 관계를 추상화 해보자!
 */

class Hue {
    var food = BranFood()
    
    func 점심() -> String {
        food.메뉴A()
    }
}

class BranFood {
    private let 주인장 = Bran()
    
    func 메뉴A() -> String {
        return 주인장.국밥() + 주인장.평양냉면() + 주인장.꿔바로우()
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

//: [Next](@next)
