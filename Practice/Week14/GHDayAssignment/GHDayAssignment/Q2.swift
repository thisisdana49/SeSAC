//
//  main.swift
//  GHDayAssignment
//
//  Created by 조다은 on 4/13/25.
//

import Foundation

func q2() {
    var a = [0, 1, 2, 3, 4]
    
    for n in 5...30 {
        let next = 2*a[n-1] + 3*a[n-2] - a[n-3] + 4*a[n-4]
        a.append(next)
    }
    
    print(a[30])
}
