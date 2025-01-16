//
//  UserDefaultsManager.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import Foundation

class UserDefaultsManager {
    // Singleton pattern
    // 다른 외부에서 UserDefaultsmanager 공간을 만들지 않고 하나의 공간에서만 쓰겠다!
    static let shared = UserDefaultsManager()
    
    private init() {}

    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
}
