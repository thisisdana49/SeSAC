//
//  BOJ6198.swift
//  QueueAssignment
//
//  Created by 조다은 on 4/7/25.
//

import Foundation

func boj_2309() {
    var array: [Int] = []
    var sum = 0

    for _ in 0..<9 {
        let n = Int(readLine()!)!
        array.append(n)
    }

    let total = array.reduce(0, +)
    var result: [Int] = []

    var found = false

    for i in 0..<9 {
        for j in i+1..<9 {
            if total - array[i] - array[j] == 100 {
                for k in 0..<9 {
                    if k != i && k != j {
                        result.append(array[k])
                    }
                }
                found = true
                break
            }
        }
        if found { break }
    }

    result.sort()

    for height in result {
        print(height)
    }
    
}
