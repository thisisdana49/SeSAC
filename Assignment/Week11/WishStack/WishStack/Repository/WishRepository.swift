//
//  WishRepository.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

protocol WishRepository {
    func getFileURL()
    func fetchAll() -> Results<Wish>
//    func createItem()
    func createItemInFolder(folder: Folder, wish: Wish)
    func deleteItem(data: Wish)
    func updateItem(data: Wish)
}

// Realm CRUD
final class WishTableRepository: WishRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() { print(realm.configuration.fileURL) }
    
    func fetchAll() -> Results<Wish> {
        return realm.objects(Wish.self)
            .sorted(byKeyPath: "money", ascending: false)
    }
    
    func createItemInFolder(folder: Folder, wish: Wish) {
        do {
            try realm.write {
//                let data = JackTable(money: .random(in: 100...10000) * 100,
//                                     category: "식비",
//                                     title: ["돈까스", "김밥", "만두"].randomElement()!,
//                                     status: true,
//                                     memo: nil)
                folder.list.append(wish)
//                realm.add(data)
                print("렘 저장 완료")
            }
        } catch {
            print("렘에 저장이 실패한 경우")
        }
    }
    
    func deleteItem(data: Wish) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("렘 데이터 삭제")
        }
    }
    
    func updateItem(data: Wish) {
//        do {
//            try realm.write {
//                realm.create(Wish.self, value: [
//                    "id": data.id,
//                    "money": 1000000000
//                ], update: .modified)
//
//            }
//        } catch {
//            print("렘 데이터 삭제")
//        }
    }
    
}
