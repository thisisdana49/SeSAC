//: [Previous](@previous)

import UIKit
/*
 @propertyWrapper
 - wrappedValue
 - projectedValue (option)
 */
@propertyWrapper
struct DanaDefaults<T> {
    let key: String
    let empty: T
    
    private(set) var projectedValue: Bool?
    
    var wrappedValue: T { // 무조건 호출
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
    
    @DanaDefaults(key: Key.age.rawValue, empty: 16)
    static var age
    @DanaDefaults(key: Key.first.rawValue, empty: false)
    static var first
    @DanaDefaults(key: Key.nick.rawValue, empty: "고래밥")
    static var nick
}

// vc
UserDefaultsManager.nick    // wrappedValue
UserDefaultsManager.$nick   // projectedValue: wrapper의 부가적인 상태를 외부에 보여주려고 할 때

//: [Next](@next)
