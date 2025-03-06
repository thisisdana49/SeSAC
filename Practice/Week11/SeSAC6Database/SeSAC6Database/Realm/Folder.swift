//
//  Folder.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted var id: ObjectId
    @Persisted var name: String
    @Persisted var favorite: Bool
    @Persisted var nameDescription: String
    
    // 1:N, to many relationship
    @Persisted var detail: List<JackTable>
    
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
