//
//  ProfileEditViewController.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class ProfileEditViewController: UIViewController {

    
    @IBOutlet var saveNicknameButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    func setUI() {
        self.navigationController?.navigationBar.topItem?.title = "설정"
        saveNicknameButton.title = "저장"
    }
}
