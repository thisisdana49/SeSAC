//
//  SecondVersionViewController.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class SecondVersionViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hamburgerMenuImage: UIImageView!
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
        
    var emotionNameArray: [String] = ["행복해", "사랑해", "좋아해", "화가나", "꿀꿀해", "지루해", "무서워", "속상해", "눈물나"]
    var emotioDegreeArray: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    fileprivate func setTopBarUI() {
        // title label
        titleLabel.text = "My Emotion Diary v.2"
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
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        emotioDegreeArray[index] += 1
        labelArray[index].text = "\(emotionNameArray[index]) \(emotioDegreeArray[index])"
    }
}
