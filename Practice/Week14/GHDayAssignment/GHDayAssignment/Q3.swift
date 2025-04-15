//
//  main.swift
//  GHDayAssignment
//
//  Created by 조다은 on 4/13/25.
//

import Foundation

func q3() {
    let str = Array(readLine()!.lowercased())
    var cnt = 0
    var v = 0
    
    for i in 0..<str.count {
        let char = str[i]
        cnt += Int(char.asciiValue!) - 96 + i
        if char == "a" || char == "e" || char == "i" || char == "o" || char == "u" {
            v += 1
        }
    }
    
    print(cnt * str.count + v)
}
