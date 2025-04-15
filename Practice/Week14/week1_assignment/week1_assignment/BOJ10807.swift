//
//  BOJ10807.swift
//  week1_assignment
//
//  Created by Bran on 3/31/25.
//

import Foundation

func boj_10807() {
  let _ = Int(readLine()!)!
  let arr = readLine()!.split(separator: " ").map { Int($0)! }
  let v = Int(readLine()!)!

  // -100 ~ 100
  var vis: [Int] = .init(repeating: 0, count: 200 + 2)
  for element in arr {
    vis[element + 100] += 1
  }

  print(vis[v + 100])
}
