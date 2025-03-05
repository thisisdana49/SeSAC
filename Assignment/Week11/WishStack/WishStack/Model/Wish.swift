//
//  Task.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import Foundation
import RealmSwift

class Wish: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    
    @Persisted(originProperty: "list")
    var folder: LinkingObjects<Folder>
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
}
