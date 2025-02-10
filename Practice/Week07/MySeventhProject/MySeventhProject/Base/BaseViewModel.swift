//
//  BaseViewModel.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/10/25.
//

import Foundation

// Genric: 호출 시 타입이 결정. 타입 파라미터
// Protocol에서 Generic은 associatedType
protocol Mentor {
    associatedtype Jack
    
    func hello(a: Jack)
}

class Test: Mentor {
    func hello(a: Jack) {
        print(a)
    }
    
    typealias Jack = String
    
    
}

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}

// 구체적으로 명세할 경우 typealias 필요 X(그대로 가져다 쓰는 경우)
// 구체적으로 명세하지 않는다면 typealias로 별칭을 설정해야 함
class Sample: BaseViewModel {
    
    struct Input {
        
    }

    struct Output {
        
    }
    
    func transform() {
        
    }
    
    
}
