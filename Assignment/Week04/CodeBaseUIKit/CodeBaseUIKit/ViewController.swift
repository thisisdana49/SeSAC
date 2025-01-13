//
//  ViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var buttonOne = {
        let button = UIButton()
        button.setTitle("Scene 1", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonOneTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var buttonTwo = {
        let button = UIButton()
        button.setTitle("Scene 2", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonTwoTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonThree = {
        let button = UIButton()
        button.setTitle("Scene 3", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonThreeTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    @objc
    func buttonOneTapped() {
        let vc = FirstViewController()
        present(vc, animated: true)
    }
    
    @objc
    func buttonTwoTapped() {
        let vc = SecondViewController()
        present(vc, animated: true)
    }
    
    @objc
    func buttonThreeTapped() {
        let vc = ThirdViewController()
        present(vc, animated: true)
    }


    func configureButtons() {
        let buttonLists = [buttonOne, buttonTwo, buttonThree]
        
        for (index, button) in buttonLists.enumerated() {
            view.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(45)
                make.centerX.equalTo(view.safeAreaLayoutGuide)
                make.top.equalTo(300 + (80 * index))
            }
        }
    }
}

#Preview {
    ViewController()
}
