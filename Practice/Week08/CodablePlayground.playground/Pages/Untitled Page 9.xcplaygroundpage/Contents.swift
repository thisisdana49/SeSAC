//: [Previous](@previous)

import UIKit

enum UserDefaultsManager {
    // 성능과 최적화에 있어서 Key의 위치를 따져보아야 함.
    enum Key: String {
        case email
        case nickname
        case phone
    }

    static var email: String {
        get {
            UserDefaults.standard.string(forKey: Key.email.rawValue) ?? "이메일 없음"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.email.rawValue)
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: Key.nickname.rawValue) ?? "닉네임 없음"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.nickname.rawValue)
        }
    }
}

UserDefaultsManager.email = "7@a.com"

//: [Next](@next)
