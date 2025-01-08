//: [Previous](@previous)

import Foundation

// 값 타입의 경우
var nickname = "다우니맛"
var subnickname = nickname
nickname = "다우니맛도리탕"

print(nickname, subnickname)

// 참조 타입의 경우
class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
var dana = User(name: "Dana")
var taylor = dana

dana.name = "chokipoki"
print(dana.name, taylor.name)

//: [Next](@next)
