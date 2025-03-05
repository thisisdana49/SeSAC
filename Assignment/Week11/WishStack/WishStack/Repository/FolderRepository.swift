//
//  FolderRepository.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

protocol FolderRepository {
    func getCurrentFolder(id: ObjectId) -> Folder
    func getCurrentFolderName(id: ObjectId) -> String
    func createItem(name: String)
    func fetchAll() -> Results<Folder>
}

final class FolderTableRepository: FolderRepository {
    
    private let realm = try! Realm()
    
    func getCurrentFolder(id: RealmSwift.ObjectId) -> Folder {
        return fetchAll().where { $0.id == id }.first!
    }
    
    func getCurrentFolderName(id: RealmSwift.ObjectId) -> String {
        return fetchAll().where { $0.id == id }.first!.name
    }
    
    func createItem(name: String) {
        do {
            try realm.write {
                let folder = Folder(name: name)
                realm.add(folder)
            }
        } catch {
            
        }
    }
    
    func fetchAll() -> Results<Folder> {
        return realm.objects(Folder.self)
    }
}
