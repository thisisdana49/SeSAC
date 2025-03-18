//
//  ViewController.swift
//  DA_Preview
//
//  Created by Bran on 3/17/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        measureTime {
            findBran(textFile)
        }
    }
}

extension ViewController {
    /// 입력값 str에서 "Bran"이라는 값이 몇 번 등장하는지 작성하세요(대, 소문자를 정확하게 구분)
    /// - Parameter str: 임의의 텍스트값
    /// - Returns: "Bran"의 등장횟수
    func findBran(_ str: String) -> Int {
        // Case 1
        let pattern = "Bran"
        let n = str.count
        let m = pattern.count
        
        let textArray = Array(str)
        let patternArray = Array(pattern)
        var count = 0
        
        for i in 0...(n - m) {
            for j in 0...3 {
                if textArray[i + j] != patternArray[j] { break }
                if j == 3 { count += 1 }
            }
        }
        
        return 0
    }
    
    func findBran2(_ str: String) -> Int {
        var count = 0
        var searchRange = str.startIndex ..< str.endIndex
        
        while let range = str.range(of: "Bran", options: [], range: searchRange) {
            count += 1
            searchRange = range.upperBound ..< str.endIndex
        }
        
        return count
    }    
    
    func measureTime(_ operation: () -> Int) {
        let start = DispatchTime.now()
        let result = operation()
        let end = DispatchTime.now()
        
        let nanoseconds = end.uptimeNanoseconds - start.uptimeNanoseconds
        let milliseconds = Double(nanoseconds) / 1_000_000
        
        print("Bran 등장회수: \(result)회")
        print("⏱️ 실행 시간: \(milliseconds)ms")
    }
    
}

