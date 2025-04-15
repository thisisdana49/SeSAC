//
//  QueueWithCircularArray.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithCirculrArray<T> {
  private var elements: [T?]
  private var front = 0
  private var rear = 0
  private let size: Int

  init(size: Int) {
    self.size = size
    self.elements = .init(repeating: nil, count: size)
  }

  private var count: Int {
    rear - front
  }

  private var isEmpty: Bool {
    count == 0
  }

  private var isFull: Bool {
    (size - count) == 0
  }
    
    // 1) Rear라는 포인터가 가리키는 인덱스에 원소를 추가하고
    // 2) Rear 1 증가시킵니다.
    // 2-1) 만약, size에 도달했다면 다시 처음으로 돌아갑니다
  mutating func push(with element: T) {
    if !isFull {
      elements[rear % size] = element
      rear += 1
    }
  }

  @discardableResult
  mutating func pop() -> T? {
    if !isEmpty {
      let element = elements[front % size]
      defer { front += 1 }
      return element
    } else {
      return nil
    }
  }
}
