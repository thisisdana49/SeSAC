//: [Previous](@previous)

import Foundation

class Guild {
    var name: String
    unowned var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var nickname: String
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User init")
    }
    
    deinit {
        print("User Deinit")
    }
}
// RC + 1
var sesac: Guild? = Guild(name: "SeSAC")

// RC + 1
var character: User? = User(nickname: "미묘한 도사")

sesac?.owner = character    // RC + 1
character?.guild = sesac    // RC + 1

// 현실적으로 불가능 -> weak, unowned를 사용하여 RC를 증가시키지 않도록 한다
//character?.guild = nil      // Rc - 1

// 인스턴스의 수명이 종료
character = nil // RC - 1
//sesac = nil     // RC - 1

character?.nickname
sesac?.name
