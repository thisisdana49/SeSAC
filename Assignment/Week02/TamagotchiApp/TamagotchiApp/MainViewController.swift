//
//  ViewController.swift
//  TamagotchiApp
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class MainViewController: UIViewController {
    var myGotchi = Tamagotchi() {
        didSet { setData() }
    }

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInformation()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let editedNickname = UserDefaults.standard.string(forKey: "userNickname") {
        speechBubbleLabel.text = "앞으로 \(myGotchi.bossName)님으로 부르면 되죠?"
//        }
        
        let randomNumber = Int.random(in: 1...10)
        switch randomNumber {
        case 1:
            speechBubbleLabel.text = "보고 싶었다구요 \(myGotchi.bossName)님~"
        case 2...4:
            speechBubbleLabel.text = "\(myGotchi.bossName)님 만나서 반가워요!"
        case 5:
            speechBubbleLabel.text = "오늘 뭔가 \(myGotchi.bossName)님을 만날 수 있을 것 같았어요😏"
        default:
            speechBubbleLabel.text = "\(myGotchi.bossName)님 만나서 반가워요!"
        }
    }

    // 왜 Right Bar Button Item이랑은 연결할 수 없을까? 아니면 나의 문제인가..? 🧐
    @IBAction func unwindToMainViewController(_ sender: UIStoryboardSegue) { }
    
    func saveUserInformation() {
        let enconder = JSONEncoder()

        if let encodeData = try? enconder.encode(myGotchi) {
            UserDefaults.standard.set(encodeData, forKey: Tamagotchi.identifier)
        }
        print(#function, myGotchi.mealCount)
    }
    
    func loadUserInformation() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: Tamagotchi.identifier) {
            if let decodeData = try? decoder.decode(Tamagotchi.self, from: data) {
                myGotchi = decodeData
            }
        }
        print(#function, myGotchi.mealCount)
    }
    
    // enum 활용해서 하나로!!
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        speechBubbleLabel.text = "\(myGotchi.bossName)님이 줘서 더 맛있는 밥이에용😋"
//        speechBubbleLabel.text = "물을 마셨더니 건강해졌어요.\n고마워요 \(userNickname)님!"

        var givenMealCount = Int(mealTextField.text != "" ? mealTextField.text! : "1")!
        if givenMealCount > 99 {
            speechBubbleLabel.text = "\(myGotchi.bossName)님, \(givenMealCount)개는 너무 많은 걸요?😵‍💫\n99개가 최대예요!"
            mealTextField.text = ""
        } else {
            myGotchi.mealCount += givenMealCount
            saveUserInformation()
            mealTextField.text = ""
        }
    }
    
    func setUI() {
        navigationItem.title = "\(myGotchi.bossName)님의 다마고치"
        view.backgroundColor = .base
        
        profileEditButton.image = UIImage(systemName: "person.crop.circle")
        profileEditButton.tintColor = .primary
        
        speechBubbleImageView.image = .bubble
        speechBubbleImageView.contentMode = .scaleAspectFill
        speechBubbleLabel.numberOfLines = 0
        speechBubbleLabel.textAlignment = .center

        levelBadgeLabel.textColor = .primary

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
    
    func setData() {
        tamagotchiImageView.image = UIImage(named: myGotchi.image)
        levelBadgeLabel.text = myGotchi.level.badge
        detailStateLabel.text = "LV\(myGotchi.level.rawValue) · 밥알 \(myGotchi.mealCount)개 · 물방울 \(myGotchi.waterCount)개"
    }
}

