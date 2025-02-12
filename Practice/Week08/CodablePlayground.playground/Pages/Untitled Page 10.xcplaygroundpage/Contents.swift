//: [Previous](@previous)

import UIKit

struct DanaDefaults {
    let key: String
    let empty: String
    var myValue: String {
        get {
            UserDefaults.standard.string(forKey: key) ?? empty
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

var  nick = DanaDefaults(key: "nick", empty: "손님")
var  phone = DanaDefaults(key: "age", empty: "0")

nick.myValue = "고래"
nick.myValue

phone.myValue
phone.myValue = "1234"
//: [Next](@next)
