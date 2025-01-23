//
//  ClosureViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/23/25.
//

import UIKit

class ClosureViewController: UIViewController {

    // 값 전달
    var contents: ((String) -> Void)?
    
    let valueTextField = SignTextField(placeholderText: "Closure를 통한 앖 전달")
    let saveButton = PointButton(title: "저장하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)

//        valueTextField.text = contents
    }
    
    @objc
    func saveButtonClicked() {
        print(#function)
        contents?(valueTextField.text!)
        navigationController?.popViewController(animated: true)
    }

    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(valueTextField)
        view.addSubview(saveButton)
         
        valueTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(valueTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
