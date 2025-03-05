//
//  FolderRepository.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

protocol FolderRepository {
    func createItem(name: String)
    func fetchAll() -> Results<Folder>
}

final class FolderTableRepository: FolderRepository {
    
    private let realm = try! Realm()
    
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
