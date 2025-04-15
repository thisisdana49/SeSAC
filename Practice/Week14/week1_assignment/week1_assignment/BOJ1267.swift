//
//  BOJ1267.swift
//  week1_assignment
//
//  Created by Bran on 4/1/25.
//

import Foundation

func boj_1267() {
  let _ = Int(readLine()!)!
  let calls = readLine()!.split(separator: " ").map { Int($0)! }

  var y = 0, m = 0
  for call in calls {
    y += ((call / 30) + 1) * 10
    m += ((call / 60) + 1) * 15
  }

  if y > m {
    print("M \(m)")
  } else if y == m {
    print("Y M \(y)")
  } else {
    print("Y \(y)")
  }
}
