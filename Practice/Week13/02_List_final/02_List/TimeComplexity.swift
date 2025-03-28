//
//  TimeComplexity.swift
//  02_List
//
//  Created by Bran on 3/27/25.
//

import Foundation
// 각 메서드들의 시간복잡도를 Big-O 표기법 기준으로 작성해보세요!

// MARK: - 1
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter arr: 길이 2 이상의 [Int] 타입의 배열
/// - Complexity: O(N)
/// - Returns: arr에서 가장 큰 값 반환
func question1(arr: [Int]) -> Int {
  var max = arr[0]
  for i in 1..<arr.count {
    if arr[i] > max {
      max = arr[i]
    }
  }
  return max

}

// MARK: - 2
/// - Parameter matrix: n x n 형태의 이중 배열
/// - Complexity: O(N^2)
/// - Returns: 2차원 배열에 있는 모든 원소의 합
func question2(_ matrix: [[Int]]) -> Int {
  var sum = 0
  for y in 0..<matrix.count {
    for x in 0..<matrix[y].count {
      sum += matrix[y][x]
    }
  }
  return sum
}

// MARK: - 3
/// AND, OR 연산 및 이진법 관련 설명 필요
/// - Parameter n: 1이상의 정수
/// - Complexity: O(1)
/// - Returns: 2의 거듭제곱인 경우 True 반환
func question3(_ n: Int) -> Bool {
  // 1000 = 8
  // 0111 = 7
  // 0000 = 0

  // 10000 = 16
  // 01111 = 15
  // 00000 = 0
  n & (n - 1) == 0
}

// MARK: - 4
/// - Parameter cube: n x m x k 형태의 삼중 배열
/// - Complexity: N * M * K, O(NMK)
/// - Returns: 3중 배열에 있는 모든 원소의 합
func question4(_ cube: [[[Int]]]) -> Int {
  var sum = 0

  for z in 0..<cube.count {
    for y in 0..<cube[z].count {
      for x in 0..<cube[z][y].count {
        sum += cube[z][y][x]
      }
    }
  }
  return sum
}

// MARK: - 5
/// 이분탐색에 대한 간단한 설명 및 이후 수업에서 다루게 될 내용
/// - Parameters:
///   - arr: 오름차순 정렬되어 있는 Int] 타입의 배열
///   - target: 찾고자 하는 값
/// - Complexity: O(logN)
/// - Returns: target의 인덱스
func question5(arr: [Int], target: Int) -> Int {
  var left = 0
  var right = arr.count - 1

  while left <= right {
    let mid = left + (right - left) / 2

    if arr[mid] == target {
      return mid
    } else if arr[mid] < target {
      left = mid + 1
    } else {
      right = mid - 1
    }
  }

  return -1
}
