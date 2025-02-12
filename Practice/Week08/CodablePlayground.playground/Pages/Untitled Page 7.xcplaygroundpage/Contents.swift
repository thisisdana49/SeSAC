import UIKit

// 오류 처리 패턴. 에러 핸들링
// 닉네임:

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    
    return format.date(from: text) == nil ? false : true
}

func validateUserInput(text: String) -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        print("빈 값")
        return false
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    // 입력한 값이 날짜 ㅎ여태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 잘못 되었습니다")
        return false
    }
    
    return true
}

// 일반 조건문
if validateUserInput(text: "20240101") {
    print("가능")
} else {
    print("불가능")
}

// 오류 처리 패턴
// 컴파일러가 오류의 타입을 인정하게 됨
enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

// 에러를 발생시킬 수 있다는 것을 알리기 위해 throw 키워드를 함수 선언부의 파라미터 뒤에 붙임
// throwing function: throw 키워드로 표시된 함수
func validateUserInputError(text: String) throws(ValidationError) -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        print("빈 값")
        throw ValidationError.emptyString
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        throw ValidationError.isNotInt
    }
    
    // 입력한 값이 날짜 ㅎ여태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 잘못 되었습니다")
        throw ValidationError.isNotDate
    }
    
    return true
}

// 지금은 오류 대응을 할 수 없는 코드
// try? 오류가 던져지면 nil로 반환. 어떤 오류가 발생했는지 알 수 없음.
// try! 무조건 성공할 경우 사용. Error가 발생하면 런타임 에러가 발생하게 됨.
let result = try? validateUserInputError(text: "")
print(result)

do {
    try validateUserInputError(text: "")
} catch ValidationError.emptyString {
    print("빈값입니다")
} catch ValidationError.isNotInt {
    print("숫자가 아닙니닷")
} catch ValidationError.isNotDate {
    print("날짜가 아닙니닷")
} catch { // if - else 의 default와 같다고 볼 수 있음
    // error는 내부적으로 오류가 발생했을 때 뱉어줌
    print(error)
}

do {
    try validateUserInputError(text: "")
} catch {
    // Error 타입을 구체적으로 정의할 수 없어서 타입캐스팅을 활용해서 처리
    // Swift5 -> Swift6 오류 타입에 대해 구체적인 정의가 가능하게 됨
    // : Typed Throws
//    switch error as? ValidationError {
    switch error  {
    case .emptyString:
        print("빈값입니다")
    default:
        print(error)
    }
}
