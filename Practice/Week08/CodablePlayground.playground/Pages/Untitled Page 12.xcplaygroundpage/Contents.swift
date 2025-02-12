//: [Previous](@previous)

import UIKit

struct DanaDefaults<T> {
    let key: String
    let empty: T
    
    var myValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? empty
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager {
    enum Key: String {
        case age, first, nick
    }
    
    static var age = DanaDefaults(key: Key.age.rawValue, empty: 16)
    static var first = DanaDefaults(key: Key.first.rawValue, empty: false)
    static var nick = DanaDefaults(key: Key.nick.rawValue, empty: "고래밥")
}

// vc
// enum, struct 구조에서 항상 myValue를 호출해야 하는 부분이 아쉬움
UserDefaultsManager.age.myValue
UserDefaultsManager.age.myValue = 99
UserDefaultsManager.age.myValue
UserDefaultsManager.age


//: [Next](@next)
