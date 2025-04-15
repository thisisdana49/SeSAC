//
//  BOJ1158.swift
//  week1_assignment
//
//  Created by Bran on 3/31/25.
//

import Foundation

func boj_1158() {
  final class Node<T> {
    var value: T
    var next: Node?

    init(value: T, next: Node? = nil) {
      self.value = value
      self.next = next
    }
  }

  let input = readLine()!.split(separator: " ").map { Int($0)! }
  let n = input[0], k = input[1]

  var head: Node<Int>? = nil
  var tail: Node<Int>? = nil

  for i in 1...n {
    let newNode = Node(value: i)

    if head == nil {
      head = newNode
      tail = newNode
      newNode.next = newNode
    } else {
      newNode.next = head
      tail!.next = newNode
      tail = newNode
    }
  }

  var answer: [Int] = []
  var current = tail

  while answer.count < n {
//    for _ in 1...k - 1 {
//      current = current?.next
//    }

    for _ in 0..<k - 1 {
      current = current?.next
    }

    let removeNode = current?.next
    answer.append(removeNode!.value)

    if removeNode?.next === removeNode {
      current?.next = nil
    } else {
      current?.next = removeNode?.next
    }
  }

  print("<\(answer.map { String($0) }.joined(separator: ", "))>")
}
