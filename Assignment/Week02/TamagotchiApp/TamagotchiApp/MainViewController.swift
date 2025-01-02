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
    var mealCount: Int = 0 {
        didSet { detailStateLabel.text = "LV1 · 밥알 \(mealCount)개 · 물방울 \(waterCount)개" }
    }
    var waterCount: Int = 0 {
        didSet { detailStateLabel.text = "LV1 · 밥알 \(mealCount)개 · 물방울 \(waterCount)개" }
    }
    
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

    // 왜 Right Bar Button Item이랑은 연결할 수 없을까? 아니면 나의 문제인가..? 🧐
    @IBAction func unwindToMainViewController(_ sender: UIStoryboardSegue) { }
    
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
        var givenMealCount = Int(mealTextField.text != "" ? mealTextField.text! : "1")!
        mealCount += givenMealCount
        mealTextField.text = ""
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        speechBubbleLabel.text = "물을 마셨더니 건강해졌어요.\n고마워요 \(userNickname)님!"
        var givenWaterCount = Int(waterTextField.text != "" ? waterTextField.text! : "1")!
        waterCount += givenWaterCount
        waterTextField.text = ""
    }
    
    func setUI() {
        navigationItem.title = "\(userNickname)님의 다마고치"
        view.backgroundColor = .base
        
        profileEditButton.image = UIImage(systemName: "person.crop.circle")
        profileEditButton.tintColor = .primary
        
        speechBubbleImageView.image = .bubble
        speechBubbleImageView.contentMode = .scaleAspectFill
        speechBubbleLabel.numberOfLines = 0
        speechBubbleLabel.textAlignment = .center
        speechBubbleLabel.text = "\(userNickname)님 만나서 반가워요!"
        
        tamagotchiImageView.image = ._2_1
        
        levelBadgeLabel.text = "방실방실 다마고치"
        levelBadgeLabel.textColor = .primary
        
        detailStateLabel.text = "LV1 · 밥알 \(mealCount)개 · 물방울 \(waterCount)개"
        detailStateLabel.textColor = .primary
        detailStateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        mealTextField.placeholder = "밥주세용"
        mealButton.setTitle("밥먹기", for: .normal)
        mealButton.setTitleColor(.primary, for: .normal)
        mealButton.layer.borderColor = UIColor.primary.cgColor
        mealButton.layer.borderWidth = 1
        mealButton.layer.cornerRadius = 10
        
        waterTextField.placeholder = "물주세용"
        waterButton.setTitle("물먹기", for: .normal)
        waterButton.setTitleColor(.primary, for: .normal)
        waterButton.layer.borderColor = UIColor.primary.cgColor
        waterButton.layer.borderWidth = 1
        waterButton.layer.cornerRadius = 10
        waterButton.layer.masksToBounds = true
    }
}

