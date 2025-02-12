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

var age = DanaDefaults(key: "age", empty: 16)
var first = DanaDefaults(key: "first", empty: false)
var nick = DanaDefaults(key: "nick", empty: "고래밥")

age.myValue = 78
first.myValue = true
nick.myValue

//: [Next](@next)
