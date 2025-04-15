//
//  BOJ.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

/// https://www.acmicpc.net/problem/2164

func boj_2164() {
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
    
    let n = Int(readLine()!)!
    var queue = QueueWithArrayPointer<Int>()
    
    for i in 1...n {
        queue.push(with: i)
    }
    
    while queue.count > 1 {
        queue.pop()
        queue.push(with: queue.pop()!)
    }
    
    print(queue.top()!)
}

func boj_2164_2() {
    let n = Int(readLine()!)!
    var queue: [Int] = []
    var front = 0
    
    for i in 1...n {
        queue.append(i)
    }
    while queue.count - front > 1 {
        front += 1
        queue.append(queue[front])
    }
    
    print(queue.first!)
}

//func boj_2164() {
//    let n = Int(readLine()!)!
//    var queue = QueueWithCirculrArray<Int>(size: n)
//    var result: [Int] = []
//    for i in 1...n {
////        queue.push(with: i)
//        result.append(i)
//    }
//    
//    while true {
//        print(result)
//        if result.count == 1 { return }
//        result.dropLast()
//        let last = result.popLast()!
//        result.insert(last, at: 0)
//    }
//    
//    print(result)
//}
