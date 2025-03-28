//
//  BOJ1406.swift
//  ListAssignment
//
//  Created by 조다은 on 3/28/25.
//

import Foundation

final class Node<T: Equatable> {
  var value: T
  var prev: Node?
  var next: Node?

  init(value: T,
       prev: Node? = nil,
       next: Node? = nil) {
    self.value = value
    self.prev = prev
    self.next = next
  }
}

extension Node: Equatable {
  static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
    lhs.value == rhs.value && lhs.next == rhs.next
  }
}

// BOJ1406
func boj1406() {
    let str = readLine()!
    let r = Int(readLine()!)!
    var cursor = str.count
    let nodes: [Node<String>] = []

    for _ in 1...r {
        let cmd = readLine()!
        if cmd.starts(with: "L") {
            if cursor == 0 { continue }
            cursor -= 1
        }
        else if cmd.starts(with: "D") {
            if cursor == str.count { continue }
            cursor += 1
        }
        else if cmd.starts(with: "B") {
            if cursor == 0 { continue }
            
        }
        else if cmd.starts(with: "P") {
            
        }
    }

    //print(str)
}
