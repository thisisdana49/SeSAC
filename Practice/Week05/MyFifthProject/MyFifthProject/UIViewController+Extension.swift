//
//  UIViewController+Extension.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/22/25.
//

import UIKit
 
// Generic: 타입에 유연하게 대응
extension UIViewController {
    // T는 Type Parameter == TextField의 플레이스 홀더
    // 무슨 타입인지는 모르지만, 동일한 타입이 들어올 것이라는 것을 알려줌.
    // Type Constraints == 네모박스 제약 설정 (클래스 제약/프로토콜 제약)
    // Gereric Paramter Pack
    // 함수 구성에선 타입을 알 수 없고 함수를 호출할 때 타입이 결정된다!!
    // 컴파일 타임에 어떤 타입이 들어올 지는 그래도 알아야 한다. (런타임 시점만이 X)
    
    func example<T>(a: T, completionHandler: @escaping (T) ->  Void) -> String {
        return "안녕하세요"
    }
    
    func plus<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a + b
    }

//    func plus(a: Double, b: Double) -> Double {
//        return a + b
//    }
//    
//    func plus(a: Float, b: Float) -> Float {
//        return a + b
//    }
    
    // 이 경우는 클래스 제약
    func configureBorder<T: UIView>(view: T) {
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .clear
    }
    
}
