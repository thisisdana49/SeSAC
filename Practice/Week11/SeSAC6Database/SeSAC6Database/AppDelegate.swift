//
//  AppDelegate.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 현재 사용자가 쓰고 있는 DB Schema Version
        migration()
        let realm = try! Realm()
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print(realm.configuration.fileURL)
            print("Schema Version", version)
        } catch {
            print("Schema Failed")
        }
        return true
    }
    
    private func migration() {
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            // 0 -> 1: Folder에 Like 추가
            // 단순히 테이블, 컬럼 추가 삭제에는 코드 필요 X
            if oldSchemaVersion < 1 {
                
            }
            // 1 -> 2: Folder에 Like 삭제
            if oldSchemaVersion < 2 {
                
            }
            // 2 -> 3:
            if oldSchemaVersion < 3 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    guard let newObject = newObject else { return }
                    
                    newObject["like"] = true
                }
            }
            // 3 -> 4: Folder like를 favorite으로 수정
            if oldSchemaVersion < 4 {
                migration.renameProperty(onType: Folder.className(), from: "like", to: "favorite")
            }
            // 4 -> 5: Folder nameDescription 추가
            // Folder name 필드 활용
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    guard let oldObject = oldObject, let newObject = newObject else { return }
                    
                    newObject["nameDescription"] = "\(oldObject["name"] ?? "") 폴더에 대해서 설명해주세요"
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

