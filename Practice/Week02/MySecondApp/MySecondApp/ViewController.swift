//
//  ViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 12/30/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var wordTextField: UITextField!
    @IBOutlet var suggestButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var posterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIButton titleLabel is read-only property!!!
        print(suggestButton.titleLabel!)
        resultLabel.isUserInteractionEnabled = true
        
        aboutOptional()
        
        // Kingfisher
//        let url = URL(string: "https://thumb.pann.com/tc_480/https://fimg5.pann.com/new/download.jsp?FileID=65482453")
        if let url = URL(string: "https://thumb.pann.com/tc_480/https://fimg5.pann.com/new/download.jsp?FileID=65482453") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(named: "star")
        }
        
        
    }
    
    // Did End on Exit
    // Outlet 연결 시 꼭 'Did End on Exit'를 선택해야함.
    // UITextField text, UILabel text : String?
    @IBAction func textFieldReturnKeyTapped(_ sender: UITextField) {
        // UITextField text에 아무리 nil을 넣어도 빈 문자열을 토해낸다.
        // text: String이기 때문에 애초에 nil을 받을 수 없다.
        // !(Forced Unwrapping)을 해도 꺼지지 않는다!
        let text = wordTextField.text!.uppercased()
        
        // TODO: 공백이 입력 되었을 때도 추가하기
        if text.count == 0 {
            resultLabel.text = "검색어를 입력해주세요."
        } else if text == "jmt" {
            resultLabel.text = "존맛탱"
        } else {
            resultLabel.text = "\(text)를 입력했어요."
        }
    }
    
    @IBAction func labelTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    func aboutOptional() {
        var nickname: String? = "다우니맛"
        var age: Int? = 100
        
        // optional이 아닌 곳에 nil을 넣을 수 X
        nickname = nil
        
        
        // 1. 조건문을 통해 옵셔널 언래핑 {
        if nickname == nil {
            print("닉네임에 문제가 있어요")
        } else {
            print("\(nickname!)으로 설정합니다.")
        }
        
        if nickname != nil {
            print("\(nickname!)으로 설정합니다.")
        } else {
            print("닉네임에 문제가 있어요")
        }
        
        
        // 2. Optional Binding: if let
        if let nickname = nickname {
            print("\(nickname)으로 설정합니다.")
        } else {
            print("닉네임에 문제가 있어요")
        }
        
        // Swift5.7 if let shorthand
        if let age {
            print("\(age)살이군요")
        } else {
            print("네? 몇 살이라구요?")
        }
        
        // 2. Optional Binding: guard let
        guard let age else {
            print("Failed to binding optional, age is nil")
            return
        }
        print(age)
        
        // 3. ?? Optional Coalescing
        print(nickname ?? "Dana")
        
        // 4. Optional Chaining
        wordTextField?.text?.count
        
        if let text = wordTextField.text {
            print(text.count)
        }
    }
}

