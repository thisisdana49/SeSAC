//: [Previous](@previous)

import UIKit

let list = ["7", "fg", "asa"]
// 서브스크립트. subscript.
list[2]

//let nick = "안녕하세요 감사해요 잘 있어요"

extension String {
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else { return nil }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

let nick = "안녕하세요 감사해요 잘 있어요 다시 만나요"
nick[11]

struct UserPhoneList {
    var contacts = [
        "01012341234",
        "01033332222",
        "01032341567",
    ]
    
    subscript(idx: Int) -> String {
        get {
            return self.contacts[idx]
        } set {
            self.contacts[idx] = newValue
        }
    }
}

let phone = UserPhoneList()
phone[0]    // phone.contacts[0]

//: [Next](@next)
