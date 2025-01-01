//
//  ProfileEditViewController.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class ProfileEditViewController: UIViewController {

    @IBOutlet var saveNicknameButton: UIBarButtonItem!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var guideLabel: UILabel!
    
    var userNickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInformation()
        setUI()
    }

    @IBAction func nicknameTextFieldDidChange(_ sender: UITextField) {
        let textCount = sender.text?.count ?? 0
        if textCount < 2 || textCount > 6 {
            navigationItem.rightBarButtonItem?.isEnabled = false
            guideLabel.text = "닉네임이 2글자 이상 6글자 이하여야 합니다."
            guideLabel.font = UIFont.systemFont(ofSize: 12)
            guideLabel.textColor = .red
        } else if sender.text == userNickname {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            guideLabel.text = ""
        }
    }

    @objc func saveNickname() {
        UserDefaults.standard.setValue(nicknameTextField.text!, forKey: "userNickname")
        print("\(UserDefaults.standard.string(forKey: "userNickname"))이 닉네임에 저장되었습니다")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUserInformation() {
        guard let userNickname = UserDefaults.standard.string(forKey: "userNickname") else { return }
        self.userNickname = userNickname
    }
    
    func setUI() {
        self.navigationController?.navigationBar.topItem?.title = "설정"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNickname))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.backgroundColor = .base
        
        nicknameTextField.text = userNickname
        nicknameTextField.placeholder = "대장의 이름을 입력해 주세요."
    }
}
