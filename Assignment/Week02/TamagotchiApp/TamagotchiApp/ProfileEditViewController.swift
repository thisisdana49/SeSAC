//
//  ProfileEditViewController.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    var bossName: String?
    let userDefaultManager = UserDefaultsManager()
    
    @IBOutlet var saveNicknameButton: UIBarButtonItem!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var guideLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserInformation()
        setUI()
    }

    @IBAction func nicknameTextFieldDidChange(_ sender: UITextField) {
        let textCount = sender.text?.count ?? 0
        if textCount < 2 || textCount > 6 {
            navigationItem.rightBarButtonItem?.isEnabled = false
            guideLabel.text = "닉네임이 2글자 이상 6글자 이하여야 합니다."
            guideLabel.font = UIFont.systemFont(ofSize: 12)
            guideLabel.textColor = .red
        } else if sender.text == bossName {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            guideLabel.text = ""
        }
    }
    
    @objc func saveNickname() {
        if let newName = nicknameTextField.text, !newName.isEmpty {
            bossName = newName
            performSegue(withIdentifier: "UnwindSegue", sender: self)
        }
    }

    func loadUserInformation() {
        bossName = userDefaultManager.bossName
    }
    
    func setUI() {
        self.navigationController?.navigationBar.topItem?.title = "설정"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNickname))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.title = "저장"
        
        view.backgroundColor = .base
        
        nicknameTextField.text = bossName
        nicknameTextField.placeholder = "\(bossName)의 새로운 이름을 입력해 주세요."
    }
}
