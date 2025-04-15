//
//  BOJ10808.swift
//  week1_assignment
//
//  Created by Bran on 3/31/25.
//

import Foundation

func boj_10808() {
  let str = readLine()!

  var vis: [Int] = .init(repeating: 0, count: 26)
  for element in str {
    vis[Int(element.asciiValue!) - Int(UnicodeScalar("a").value)] += 1
  }

  print(vis.map { String($0) }.joined(separator: " "))
}
