import UIKit

/*
 Function Types
 

 First Class Object
 1. 변수/ 상수에 함수를 쓸 수 있다.
 2. 인자값
 3. 반환값
 */


// () -> String Function Type
//func introduce() -> String {
//    print("안녕하세요")
//    return "안녕하세요"
//}
//
// (String) -> String
func introduce(name: String) -> String {
    return "안녕하세요 저는 \(name)입니다."
}

let test = {
    print("안녕하세요")
    return "안녕하세요"
}

let bran = { (name: String) in // 함수의 형식과 본문을 구분하는 지표 : 클로저 헤더
    return "안녕하세요 저는 \(name)입니다." // 클로저 바디
}
bran("Bran")


func introduce(nickname: String) -> String {
    return "안녕 나는 \(nickname)입니다."
}

// () -> ()
func introduce() {
    print("안녕하세요")
}

//let jack = introduce() 이건 결과값을 담은 것


// 함수의 오버로딩 특성으로, 함수를 구별하기 어려워지면 타입 어노테이션으로 함수를 구분할 수 있따.
//let jack: () -> () = introduce
//jack()

let jack: (String) -> String = introduce(nickname:)
// 그런데 만약 탕비 어노테이션만으로 구별이 어렵다면, 함수 시벽자로 구분할 수 있다.
//jack()


// () -> ()
func oddNumber() {
    print("홀수")
}
func evenNumber() {
    print("짝수")
}

func resultNumber(value: Int, odd: () -> (), even: () -> ()) {
    if value.isMultiple(of: 2) {
        even()
    } else {
        odd()
    }
}

resultNumber(value: 10, odd: oddNumber, even: evenNumber)

resultNumber(value: 111, odd: { print("홀") }, even: { print("짝") })

resultNumber(value: 101) {
    print("홀수")
} even: {
    print("짝수")
}

