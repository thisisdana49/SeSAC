//
//  LikeProductModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 3/4/25.
//

import Foundation
import RealmSwift

final class LikeListTable: Object {
    @Persisted(primaryKey: true) var productId: String // PK - index embed
    @Persisted(indexed: true) var title: String     // 내용
    @Persisted var mallName: String     // 메모
    @Persisted var image: String      // 수입/지출 여부
    @Persisted var lprice: String       // 가격
    @Persisted var like: Bool        // 좋아요
    
    convenience init(productId: String,
                     title: String,
                     mallName: String,
                     image: String,
                     lprice: String,
                     like: Bool
    ) {
        self.init()
        self.productId = productId
        self.title = title
        self.mallName = mallName
        self.image = image
        self.lprice = lprice
        self.like = like
    }
}
