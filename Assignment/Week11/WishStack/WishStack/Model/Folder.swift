//
//  Folder.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted var id: ObjectId
    @Persisted var name: String
    @Persisted var list: List<Wish>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
