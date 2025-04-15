//
//  QueuewithArrayPointer.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithArrayPointer<T> {
  private var elements: [T] = []
  private var front = 0

  var isEmpty: Bool {
      elements.count - front < 1
  }

  var count: Int {
    elements.count - front
  }

  mutating func push(with element: T) {
      elements.append(element)
  }

  @discardableResult
  mutating func pop() -> T? {
//      let frontElement = elements[front]
//      front += 1
//      return frontElement
      if isEmpty {
          return nil
      } else {
          defer { front += 1 }
          return elements[front]
      }
  }

  func top() -> T? {
      if isEmpty {
          return nil
      } else {
          return elements[front]
      }
  }
}

//extension QueueWithArrayPointer: CustomStringConvertible {
//  var description: String {
//    (front..<elements.count).map { elements[$0] }.description
//  }
//}
