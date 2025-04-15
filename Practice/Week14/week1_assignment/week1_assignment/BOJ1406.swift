//
//  BOJ1406.swift
//  week1_assignment
//
//  Created by Bran on 3/31/25.
//

import Foundation

func boj_1406() {
  final class Node<T> {
    var value: T
    var prev: Node?
    var next: Node?

    init(value: T, prev: Node? = nil, next: Node? = nil) {
      self.value = value
      self.prev = prev
      self.next = next
    }
  }

  let first = readLine()!.map { String($0) }
  let m = Int(readLine()!)!

  ///  a b c
  /// |   |  |  |
  let dummy = Node<String>(value: "")
  var cursor = dummy

  var lastNode = dummy
  for element in first {
    let newNode = Node<String>(value: element, prev: lastNode)
    lastNode.next = newNode
    lastNode = newNode
    cursor = lastNode
  }

  for _ in 1...m {
    let order = readLine()!.split(separator: " ").map { String($0) }
    if order[0] == "L" {
      if cursor !== dummy {
        cursor = cursor.prev!
      }
    } else if order[0] == "D" {
      if cursor.next != nil {
        cursor = cursor.next!
      }
    } else if order[0] == "B" {
      if cursor !== dummy {
        cursor.prev?.next = cursor.next
        cursor.next?.prev = cursor.prev
        cursor = cursor.prev!
      }
    } else {
      let newNode = Node(value: order[1], prev: cursor, next: cursor.next)
      cursor.next?.prev = newNode
      cursor.next = newNode
      cursor = newNode
    }
  }

  var answer = ""
  var current = dummy.next

  while current != nil {
    answer.append(current!.value)
    current = current?.next
  }

  print(answer)
}
