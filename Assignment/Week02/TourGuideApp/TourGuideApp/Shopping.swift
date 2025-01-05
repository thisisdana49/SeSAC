//
//  Shopping.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/5/25.
//

import Foundation

struct Shopping {
    let title: String
    let done: Bool
    let bookmark: Bool
}

struct ShoppingList {
    let list: [Shopping] = [
        Shopping(title: "여권 케이스 구매", done: true, bookmark: false),
        Shopping(title: "귀여운 수영복", done: false, bookmark: true),
        Shopping(title: "많이 들어가는 편한 가방", done: false, bookmark: false)
    ]
}
