//
//  ViewController.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var profileEditButton: UIBarButtonItem!
    @IBOutlet var speechBubbleImageView: UIImageView!
    @IBOutlet var speechBubbleLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var levelBadgeLabel: UILabel!
    @IBOutlet var detailStateLabel: UILabel!
    @IBOutlet var mealTextField: UITextField!
    @IBOutlet var mealButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    
    var userNickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserInformation()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let editedNickname = UserDefaults.standard.string(forKey: "userNickname") {
            if userNickname != editedNickname {
                self.userNickname = editedNickname
                speechBubbleLabel.text = "앞으로 \(userNickname)님으로 부르면 되죠?"
            }
        }
        
        let randomNumber = Int.random(in: 1...10)
        switch randomNumber {
        case 1:
            speechBubbleLabel.text = "보고 싶었다구요 \(userNickname)님~"
        case 5:
            speechBubbleLabel.text = "오늘 뭔가 \(userNickname)님을 만날 수 있을 것 같았어요😏"
        default:
            speechBubbleLabel.text = "\(userNickname)님 만나서 반가워요!"
        }
    }

    @IBAction func unwindToMainViewController(_ sender: UIStoryboardSegue) { }
    // 왜 Right Bar Button Item이랑은 연결할 수 없을까? 아니면 나의 문제인가..? 🧐
    
    func setUserInformation() {
        guard let userNickname = UserDefaults.standard.string(forKey: "userNickname") else {
            UserDefaults.standard.set("대장", forKey: "userNickname")
            userNickname = "대장"
            return
        }
        
        self.userNickname = userNickname
    }
    
    @IBAction func mealButtonTapped(_ sender: UIButton) {
        speechBubbleLabel.text = "\(userNickname)님이 줘서 더 맛있는 밥이에용😋"
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        speechBubbleLabel.text = "물을 마셨더니 건강해졌어요. 고마워요 \(userNickname)님!"
    }
    
    
    func setUI() {
        navigationItem.title = "\(userNickname)님의 다마고치"
        
        profileEditButton.image = UIImage(systemName: "person.crop.circle")
        
        speechBubbleImageView.image = .bubble
        speechBubbleImageView.contentMode = .scaleAspectFill
        speechBubbleLabel.numberOfLines = 0
        speechBubbleLabel.textAlignment = .center
        speechBubbleLabel.text = "\(userNickname)님 만나서 반가워요!"
        
        tamagotchiImageView.image = ._2_1
        
        levelBadgeLabel.text = "방실방실 다마고치"
        detailStateLabel.text = "LV1 · 밥알 0개 · 물방울 0개"
        
        mealTextField.placeholder = "밥주세용"
        mealButton.setTitle("밥먹기", for: .normal)
        
        waterTextField.placeholder = "물주세용"
        waterButton.setTitle("물먹기", for: .normal)
    }
}

