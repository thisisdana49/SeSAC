//
//  UserDefaultsManager.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/10/25.
//

import Foundation

class UserDefaultsManager {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private let userDefault = UserDefaults.standard
    
    var tamagotchi: Tamagotchi? {
        get {
            if let data = UserDefaults.standard.data(forKey: Tamagotchi.identifier) {
                if let decodeData = try? decoder.decode(Tamagotchi.self, from: data) {
                    return decodeData
                }
            }
            return nil
        }
        set {
            if let encodeData = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodeData, forKey: Tamagotchi.identifier)
            }
        }
    }
    
    var bossName: String {
        get {
            if let data = UserDefaults.standard.data(forKey: Tamagotchi.identifier) {
                if let decodeData = try? decoder.decode(Tamagotchi.self, from: data) {
                    return decodeData.bossName
                }
            }
            return ""
        }
    }
}
