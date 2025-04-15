//
//  main.swift
//  GHDayAssignment
//
//  Created by 조다은 on 4/13/25.
//

import Foundation

func q1() {
    let n = Int(readLine()!)!
    var cnt = 0
    
    for i in 1...n {
        let str = String(i)
        for c in str {
            if c == "3" || c == "6" || c == "9" {
                cnt += 1
            }
        }
    }
    
    print(cnt)
}
