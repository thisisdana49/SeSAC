//
//  BlackRadiusLabel.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/15/25.
//

import UIKit

protocol SeSAC {
    init()
}

class Mentor: SeSAC {
    
    required init() {
        print("Mentor Init")
    }
}

class Jack: Mentor {
//    required init() {
//        super.init()
//        print("Jack Init")
//    }
    // 프로토콜/ 슈퍼 클래스 init 모두 가능
    override required init() {
        super.init()
        print("Jack Init")
    }
}

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}


class BlackRadiusLabel: BaseLabel {
    
    init(color: UIColor) {
        super.init(frame:  .zero)
        
        self.font = .boldSystemFont(ofSize: 15)
        self.textColor = color
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
    }
    
    // 코드 베이스로 코드를 구성할 때 호출되는 초기화 구문
    // Init From Super Class
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    // 스토리보드로 구성할 때 호출되는 초기화 구문
    // Init From Protocol (e.g. tableView - cellForRowAt)
    // init 뒤의 물음표 => 실패 가능한 이니셜라이저(Failable Initializer)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
