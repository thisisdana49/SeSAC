//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

class Mobile { // Base
    var name: String
    var nickname = "다우니" {
        willSet {
            print(newValue, nickname)
        }
        didSet {
            print(oldValue, nickname)
        }
    }
    
    var introduce: String { // '통로'로 이해하면 쉬움
        get {
            return "당신은 \(name) 제품을 구매했고 구매 날짜는 \(Date())입니다."
        }
        set {
            name = newValue
            nickname = newValue
            print("It has set. Current name of this instance is \(name)")
        }
    }
    init(name: String) {
        self.name = name
    }
    
    func buy() {
        print("Bought It.")
    }
    
    static func test() {
        
    }
}

class Google: Mobile { // Super
    override init(name: String) {
        super.init(name: name)
    }
    
    override func buy() {
        print("Bought Google")
    }

}

class Android: Mobile { // Sub
    override func buy() {
        print("Bought aOS")
    }
}

// e.g. 카톡에서 인앱 알림 -> 현재 채팅방일 때는 인앱 알림이 뜨지 않음.

class Apple: Mobile {
    let wwdc = "WWDC"
}

let phone = Mobile(name: "Phone")
print(phone.introduce)
phone.introduce = "오잉"

let google = Google(name: "Google")

let apple = Apple(name: "Apple")

apple as Mobile

phone is Mobile
google is Mobile
apple is Mobile

phone is Google
phone is Apple

apple is Google

// as? 옵셔널 반환 타입 => nil
// as! => 실패하면 무조건 런타임 오류 발생


//let example = iPhone as! Apple

var iPhone: Mobile = Apple(name: "APPLE")
iPhone = Google(name: "iGle")

if let phone = iPhone as? Apple {
    phone.wwdc
} else {
    // 에러 처리
}

// Any VS AnyObject
var somethings: [Any] = []
somethings = ["1", 2, true, iPhone] // 다 가능한

print(somethings[3])

if let element = somethings[3] as? Google {
    print(element.name)
}

// AnyObject는 오직 클래스의 인스턴스만 다룬다
var someObject: [AnyObject] = []
someObject.append(google)
someObject.append(iPhone)



let googleTwo = Google(name: "google 2")
let android = Android(name: "android")

googleTwo.buy()
android.buy()
//: [Next](@next)
