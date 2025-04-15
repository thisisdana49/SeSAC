//
//  QueuewithArray.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithArray<T> {
  private var elements: [T] = []

  mutating func push(with element: T) {
      elements.append(element)
  }

  @discardableResult
  mutating func pop() -> T? {
      return elements.isEmpty ? nil : elements.removeFirst()
//      let element = elements.first
//      elements.remove(at: 0)
//      return element
  }

  func top() -> T? {
      return elements.first
  }
}

extension QueueWithArray: CustomStringConvertible {
  var description: String {
    elements.description
  }
}
