//
//  main.swift
//  GHDayAssignment
//
//  Created by 조다은 on 4/13/25.
//

import Foundation

func q4() {
    let a = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
    var cnt = 0
    
    for i in 0..<a.count {
        for j in 0...i {
            cnt += a[j]
        }
        
    }
    print(cnt)
}
