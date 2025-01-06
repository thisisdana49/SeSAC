//
//  UIColor+Extension.swift
//  MySecondApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit

extension UIColor {
    // 저장 프로퍼티, 인스턴스 프로퍼티 => 사용할 수 없다
//    var jackColor = UIColor.red
    
    // 저장 프로퍼티, 타입 프로퍼티
    static var backColor = UIColor.red
    
    // 연산 프로퍼티, 인스턴스 프로퍼티 => 사용할 수 있다
    var denColor: UIColor {
        return .red
    }
    
}
