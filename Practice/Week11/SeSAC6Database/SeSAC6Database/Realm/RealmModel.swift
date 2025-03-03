//
//  RealmModel.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/4/25.
//

//class User: Hashable, Equatable {
//    
//    static func == (lhs: User, rhs: User) -> Bool {
//        <#code#>
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        <#code#>
//    }
//    
//    let id = UUID()
//    let name: String
//    let age: Int
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}

import Foundation
import RealmSwift

class JackTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId // PK - index embed
    @Persisted var money: Int        // 금액
    @Persisted var category: String  // 카테고리
    @Persisted(indexed: true) var title: String     // 내용 
    @Persisted var status: Bool      // 수입/지출 여부
    @Persisted var memo: String?     // 메모
    @Persisted var regDate: Date     // 등록일
    @Persisted var like: Bool        // 좋아요
    
//    @Persisted var Poster: Data?
    
    // 어떻게 연결 되어있는지, Column의 명
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<Folder>
    
    convenience init(money: Int,
                     category: String,
                     title: String,
                     status: Bool,
                     memo: String?
    ) {
        self.init()
        self.money = money
        self.category = category
        self.title = title
        self.status = status
        self.memo = memo
        self.regDate = Date()
        self.like = false
    }
}
