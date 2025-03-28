//
//  BOJ10807.swift
//  ListAssignment
//
//  Created by 조다은 on 3/28/25.
//

import Foundation

// BOJ10807
func boj10807() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let v = Int(readLine()!)!
    var cnt = 0

    for e in arr {
        if e == v { cnt += 1 }
    }
    print(cnt)
}
