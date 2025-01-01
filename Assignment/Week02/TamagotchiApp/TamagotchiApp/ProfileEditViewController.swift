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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        navigationItem.rightBarButtonItem = saveNicknameButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNickname))
    }

    @IBAction func nicknameTextFieldDidChange(_ sender: UITextField) {
        let textCount = sender.text?.count ?? 0
        if textCount >= 2 && textCount <= 6 {
            saveNicknameButton.isEnabled = true
            guideLabel.text = ""
        } else {
            saveNicknameButton.isEnabled = false
            guideLabel.text = "닉네임이 2글자 이상 6글자 이하여야 합니다."
            guideLabel.font = UIFont.systemFont(ofSize: 12)
            guideLabel.textColor = .red
        }
    }

    @objc func saveNickname() {
        UserDefaults.standard.setValue(nicknameTextField.text!, forKey: "userNickname")
        print("\(UserDefaults.standard.string(forKey: "userNickname"))이 닉네임에 저장되었습니다")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUI() {
        self.navigationController?.navigationBar.topItem?.title = "설정"
        saveNicknameButton.title = "저장"
        saveNicknameButton.isEnabled = false
        
        guideLabel.text = ""
    }
}
