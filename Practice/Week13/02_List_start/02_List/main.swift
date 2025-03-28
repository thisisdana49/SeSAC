//
//  main.swift
//  02_List
//
//  Created by Bran on 3/20/25.
//

import Foundation
/*
 9
 5 12 7 10 9 1 2 3 11
 13
 */

/*
 i < j (Ai, Aj)
 (12, 1) 12 -> x - 12라는 값이 배열에 존재하니?
 (10, 3) 10 -> x - 10라는 값이 배열에 존재하니?
 */

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }.sorted { $0 > $1 }
let x = Int(readLine()!)!

var vis: [Bool] = .init(repeating: false, count: 2000000 + 2)
var answer = 0

for element in arr {
    vis[element] = true
}

for element in arr {
    if element < x && vis[x - element] { answer += 1 }
}

print(answer / 2)


//var cnt = 0
//
//for i in 0...n - 1 {
//    if (arr[i] < x) {
//        for j in 0...n - 1 {
////            print(arr[i], arr[j])
//            if i == j { continue }
//            else if arr[i] + arr[j] == x {
//                print(arr[i], arr[j])
//                cnt += 1
//            }
//        }
//
//    }
//}
//
//print(cnt / 2)


// MARK: - ArrayList / Capactiy
//checkCapacity()
//checkReserveCapacity()


// MARK: - Linked List
//var a = LinkedList<String>()
//a.append("Hue")
//a.append("Jack")
//
//print(a)
//
//a.insert("Bran", at: 2)
//print(a)
//
//a.insert("Den", at: 2)
//print(a)
//
//a.removeLast()
//print(a)
//
//a.removeFirst()
//print(a)
//
//print(a.count)
