//
//  ViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let buttonOne = {
        let button = UIButton()
        button.setTitle("Scene 1", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let buttonTwo = {
        let button = UIButton()
        button.setTitle("Scene 2", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let buttonThree = {
        let button = UIButton()
        button.setTitle("Scene 3", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
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
