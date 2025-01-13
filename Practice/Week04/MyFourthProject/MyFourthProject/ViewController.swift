//
//  ViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

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
    let nameTextField = UITextField()
    
    let redView = UIView()
    let greenView = UIView()
    let grayView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameBasedLayout()
        autoLayoutConstraints()
        autoLayoutAnchor()
        autoLayoutSnapKit2()
//        autoLayoutSnapKit()
    }
    
    func autoLayoutSnapKit2() {
        view.addSubview(redView)
        view.addSubview(grayView)
        redView.addSubview(greenView)
        
        redView.backgroundColor = .red
        grayView.backgroundColor = .gray
        greenView.backgroundColor = .green
        
         redView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        greenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        grayView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50)
        }
    }
    
    func autoLayoutSnapKit() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(grayView)
//        nameTextField.addSubview() 불가능! 다른 view를 포함할 수 없기 때문
        
        // 이미 SnapKit 내부에서 설정해주고 있기 때문에 사용하지 않는 쪽이 맞음.
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
                      
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(view)
//            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.verticalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
//            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        greenView.snp.makeConstraints { make in
//            make.centerX.equalTo(view.safeAreaLayoutGuide)
//            make.centerY.equalTo(view.safeAreaLayoutGuide)
//            make.width.height.equalTo(300)
//            make.width.equalTo(300)
//            make.height.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(50)
            make.centerX.equalTo(greenView.snp.centerX).offset(-100)
            make.size.equalTo(200)
        }
    }
    
    func autoLayoutAnchor() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        nameTextField.backgroundColor = .orange
    }
    
    func autoLayoutConstraints() {
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
        
        let leading = NSLayoutConstraint(item: passwordTextField,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view.safeAreaLayoutGuide,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 40
        )
        
        let trailing = NSLayoutConstraint(item: passwordTextField,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view.safeAreaLayoutGuide,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: -40
        )
        
        let height = NSLayoutConstraint(item: passwordTextField,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 50
        )
        view.addConstraints( [top, leading, trailing, height])
        
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

