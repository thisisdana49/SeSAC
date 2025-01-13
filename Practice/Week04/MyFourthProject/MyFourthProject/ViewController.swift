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
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameBasedLayout()
        
        view.addSubview(passwordTextField)
        // Convert From Auto resizing to Constraints
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: passwordTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 50
        )
        top.isActive = true
        
        let leading = NSLayoutConstraint(item: passwordTextField,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 40
        )
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: passwordTextField,
                                          attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -40
        )
        trailing.isActive = true
        
        let height = NSLayoutConstraint(item: passwordTextField,
                                        attribute: .height,
                           relatedBy: .equal,
                                        toItem: view.safeAreaLayoutGuide,
                           attribute: .height,
                           multiplier: 1,
                           constant: 50
        )
        height.isActive = true
        passwordTextField.backgroundColor = .yellow
    }
    
    func frameBasedLayout() {
        // 2. addSubView로 뷰 추가
        view.addSubview(emailTextField)
        
        // 3. 뷰의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 293, height: 50)
        emailTextField.backgroundColor = .lightGray
    }

}

