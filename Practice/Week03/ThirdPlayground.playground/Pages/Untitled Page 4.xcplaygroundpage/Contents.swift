//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

UserDefaults.standard.set(100, forKey: "age")
UserDefaults.standard.integer(forKey: "age")

class DanaUserDefaults {
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        } set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "대장"
        } set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
            print("Nickname has set")
        }
    }
}

let dana = DanaUserDefaults()
dana.age

import UIKit
class VC: UIViewController {
    let dana = DanaUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = dana.nickname
        // 직접 UserDefaults에 가지 않아도 Dana를 통해 가져올 수 있다.
        
        saveButtonClicked()
    }
    
    func saveButtonClicked() {
        dana.nickname = "dana"
    }
}

//: [Next](@next)
