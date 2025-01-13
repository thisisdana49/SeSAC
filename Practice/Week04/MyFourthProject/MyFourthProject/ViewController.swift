//
//  ViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/13/25.
//

import UIKit

/*
1. 스토리보드에서 객체 얹기
2. 객체 레이아웃 잡기
3. 아웃렉 연결하기
4. 객체 속성 코드로 조절하기
*/

class ViewController: UIViewController {
    // 1. Outlet 연결 대신 클래스 인스턴스를 생성해서 담아줌 - 뷰 객체 프로퍼티 ㅅ너언
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameBasedLayout()
    }
    
    func frameBasedLayout() {
        // 2. addSubView로 뷰 추가
        view.addSubview(emailTextField)
        
        // 3. 뷰의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 293, height: 50)
        emailTextField.backgroundColor = .lightGray
    }

}

