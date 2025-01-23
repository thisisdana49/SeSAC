//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
   
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    deinit {
        print(self)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(statusLabel)
        view.addSubview(nextButton)
         
        statusLabel.text = "메인 화면"
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

