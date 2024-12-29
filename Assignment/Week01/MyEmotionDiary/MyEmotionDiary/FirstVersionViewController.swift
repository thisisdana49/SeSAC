//
//  ViewController.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class FirstVersionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hamburgerMenuImage: UIImageView!
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    
    @IBOutlet var versioinTwoButton: UIButton!
    
    var emotionNameArray: [String] = ["행복해", "사랑해", "좋아해", "화가나", "꿀꿀해", "지루해", "무서워", "속상해", "눈물나"]
    var emotioDegreeArray: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    fileprivate func setTopBarUI() {
        // title label
        titleLabel.text = "My Emotion Diary"
        titleLabel.textAlignment = .center
        
        // hamburger menu image view
        let image = UIImage(systemName: "line.horizontal.3")
        hamburgerMenuImage.image = image
        hamburgerMenuImage.tintColor = .black
    }
    
    fileprivate func setEmotionButtonUI() {
        for index in 0...8 {
            let button = buttonArray[index]
            let label = labelArray[index]
            
            button.setImage(UIImage(named: "mono_slime\(index+1)"), for: .normal)
            label.text = "\(emotionNameArray[index]) \(emotioDegreeArray[index])"
            label.textAlignment = .center
        }
    }
    
    func setUI() {
        setTopBarUI()
        setEmotionButtonUI()
        
        view.backgroundColor = .primary
        
        versioinTwoButton.setTitle("Go to version 2", for: UIControl.State.normal)
        versioinTwoButton.setTitleColor(.white, for: .normal)
        versioinTwoButton.backgroundColor = .black
        versioinTwoButton.layer.cornerRadius = 5
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let randomNumber = Int.random(in: 1...100)
        emotioDegreeArray[index] = randomNumber
        labelArray[index].text = "\(emotionNameArray[index]) \(emotioDegreeArray[index])"
    }
}
