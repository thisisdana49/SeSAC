//
//  JackRepository.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

protocol JackRepository {
    func getFileURL()
    func fetchAll() -> Results<JackTable>
//    func createItem()
    func createItemInFolder(folder: Folder, data: JackTable)
    func deleteItem(data: JackTable)
    func updateItem(data: JackTable)
}

// Realm CRUD
final class JackTableRepository: JackRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() { print(realm.configuration.fileURL) }
    
    func fetchAll() -> Results<JackTable> {
        return realm.objects(JackTable.self)
            .sorted(byKeyPath: "money", ascending: false)
    }
    
    func createItemInFolder(folder: Folder, data: JackTable) {
        // Creat
        do {
            try realm.write {
                // 어떤 폴더에 넣어줄지
//                let folder = realm.objects(Folder.self).where { $0.name == "개인" }.first!
                
//                let data = JackTable(money: .random(in: 100...10000) * 100,
//                                     category: "식비",
//                                     title: ["돈까스", "김밥", "만두"].randomElement()!,
//                                     status: true,
//                                     memo: nil)
                folder.detail.append(data)
//                realm.add(data)
                print("렘 저장 완료")
            }
        } catch {
            print("렘에 저장이 실패한 경우")
        }
    }
    
    // 폴더 지정 없이 그냥 추가하는 케이스
//    func createItem() {
//        // Creat
//        do {
//            try realm.write {
////                let data = JackTable(money: .random(in: 100...10000),
////                                     category: categoryField.text!,
////                                     title: titleTextField.text!,
////                                     status: false,
////                                     memo: memoField.text)
//                let data = JackTable(money: .random(in: 100...10000) * 100,
//                                     category: "식비",
//                                     title: ["돈까스", "김밥", "만두"].randomElement()!,
//                                     status: true,
//                                     memo: nil)
//                realm.add(data)
//                print("렘 저장 완료")
//            }
//        } catch {
//            print("렘에 저장이 실패한 경우")
//        }
//    }
    
    func deleteItem(data: JackTable) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("렘 데이터 삭제")
        }
    }
    
    func updateItem(data: JackTable) {
        do {
            try realm.write {
                realm.create(JackTable.self, value: [
                    "id": data.id,
                    "money": 1000000000
                ], update: .modified)

            }
        } catch {
            print("렘 데이터 삭제")
        }
    }
    
}
