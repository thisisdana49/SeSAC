//
//  BOJ1158.swift
//  ListAssignment
//
//  Created by 조다은 on 3/28/25.
//

import Foundation

// BOJ3273
func boj3273() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }.sorted { $0 > $1 }
    let x = Int(readLine()!)!
    
    var vis: [Bool] = .init(repeating: false, count: 2000000 + 2)
    var answer = 0
    
    for element in arr {
        vis[element] = true
    }
    
    for element in arr {
        if element < x && vis[x - element] { answer += 1 }
    }
    
    print(answer / 2)
}
