//
//  main.swift
//  02_List
//
//  Created by Bran on 3/20/25.
//

import Foundation

/*
 n = 9
 arr = 5 12 7 10 9 1 2 3 11
 x = 13
 */

/*
i < j (Ai, Aj)
(12, 1) 12 -> x - 12 라는 값이 배열에 존재하니?
(10, 3) 10 -> x - 10 라는 값이 배열에 존재하니?
(2, 11)
 */

/*
 n = 9
 arr = 5 12 7 10 9 1 2 3 11
 x = 13

vis: [Bool] = [][v][v][v][][v][][v][][v][v][v][v] // N
elemet in arr {
 if vis[x - element] { answer += 1 }
}

 */

// O(N^2)
//for i in 0..<arr.count {
//  for j in i + 1..<arr.count
//
//}

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }
let x = Int(readLine()!)!

var vis: [Bool] = .init(repeating: false, count: 2000000 + 2)
var answer = 0

// vis: [Bool] = [][v][v][v][][v][][v][][v][v][v][v] // N
for element in arr {
  vis[element] = true
}

/*
 (ai, aj) i < j
 n = 9
 arr = 5 12 7 10 9 1 2 3 11
 x = 13

 (12, 1) 12 -> x - 12 라는 값이 배열에 존재하니?
 (10, 3) 10 -> x - 10 라는 값이 배열에 존재하니?
 (2, 11)

  i < j
 (1, 12)
 (3, 10)
 (11, 2)
 */
for element in arr {
  if element < x && vis[x - element] { answer += 1 }
}

print(answer / 2)
