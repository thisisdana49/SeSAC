//
//  SearchViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/22/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {

    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(textField)
        
        textField.backgroundColor = .yellow
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        textField.resignFirstResponder()
        // 키보드를 직접적으로 내리는 것이 아니라, 커서를 해제한다고 보는 것이 더 옳음
        return true
    }
}
