//
//  BOJ10808.swift
//  ListAssignment
//
//  Created by 조다은 on 3/28/25.
//

import Foundation

// BOJ10808
func boj10808() {
    let str = readLine()!
    let chars: [Character] = Array(str)
    var arr: [Int] = .init(repeating: 0, count: 26)

    for char in chars {
        arr[Int(char.asciiValue!) - 97] += 1
    }

    print(arr.map { String($0) }.joined(separator: " "))
}
