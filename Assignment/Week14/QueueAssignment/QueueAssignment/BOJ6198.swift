//
//  BOJ6198.swift
//  QueueAssignment
//
//  Created by 조다은 on 4/7/25.
//

import Foundation

func boj_6198() {
    let n = Int(readLine()!)!
    var array: [Int] = []
    var stack: [Int] = []
    var answer = 0
    for _ in 0..<n {
        let n = Int(readLine()!)!
        array.append(n)
    }

    for i in 0..<n {
        while stack.count != 0 && stack.last! <= array[i] {
            stack.removeLast()
        }
        
        stack.append(array[i])
        answer += stack.count - 1
    }

    print(answer)
}
