//
//  TimeComplexity.swift
//  01_Complexity
//
//  Created by Bran on 3/24/25.
//

import Foundation

/// 각 메서드들의 시간복잡도를 Big-O 표기법 기준으로 작성해보세요!

// MARK: - 1
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter arr: [Int] 타입의 배열
/// - Complexity:2N + 2 -> O(N)
/// - Returns: 배열 요소 중 최댓값
func question1(arr: [Int]) -> Int {
  var max = arr[0]  // 1
  for i in 1..<arr.count {
    if arr[i] > max {   // 1
      max = arr[i]  // 1
    }
  }
  return max    // 1

}

// MARK: - 2
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter matrix: n x n 형태의 이중 배열
/// - Complexity:O(N^2)
/// - Returns: 해당 배열의 요소의 총합
func question2(_ matrix: [[Int]]) -> Int {
  var sum = 0   // 1
  for y in 0..<matrix.count {   // 2
    for x in 0..<matrix[y].count {  // 2
      sum += matrix[y][x]
    }
  }
  return sum
}

// MARK: - 3
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter n: 1이상의 정수
/// - Complexity: O(1)
/// - Returns: n의 2의 거듭제곱 여부
func question3(_ n: Int) -> Bool {
  n & (n - 1) == 0  // 3
    // & 연산자:
}

// MARK: - 4
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter cube: n x m x k 형태의 삼중 배열
/// - Complexity:O(N * M * K)
/// - Returns:해당 배열의 요소의 총합
func question4(_ cube: [[[Int]]]) -> Int {
  var sum = 0   // 1
  for z in 0..<cube.count { // n
    for y in 0..<cube[z].count {    // m
      for x in 0..<cube[z][y].count {   // k
        sum += cube[z][y][x]
      }
    }
  }
  return sum
}

// MARK: - 5
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameters:
///   - arr: 오름차순 정렬되어 있는 Int] 타입의 배열
///   - target: 찾고자 하는 값
/// - Complexity:O(log N)
/// - Returns: 배열에서 찾고자하는 값의 인덱스, 없을 시 -1
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
