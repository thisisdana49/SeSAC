//
//  main.swift
//  Preivew0
//
//  Created by 조다은 on 3/18/25.
//

import Foundation

let input = readLine()!
    .split(separator: " ")
    .map({ Int($0)! })

print(input[0] + input[1])
