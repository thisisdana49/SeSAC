//
//  ViewController.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class FirstVersionViewController: UIViewController {
    let keyIdentifier = "emotionVer1"
    var emotions = EmotionInfo().emotions

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hamburgerMenuImage: UIImageView!
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    
    @IBOutlet var versioinTwoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEmotionData()
        setUI()
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let randomNumber = Int.random(in: 1...100)
        emotions[index].degree = randomNumber
        labelArray[index].text = emotions[index].info
        
        saveEmotionData()
    }
    
    func saveEmotionData() {
        let encoder = JSONEncoder()
        
        if let encodeData = try? encoder.encode(emotions) {
            UserDefaults.standard.set(encodeData, forKey: keyIdentifier)
            print(#function, encodeData)
        }
    }
    
    func loadEmotionData() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: keyIdentifier) {
            if let decodeData = try? decoder.decode([Emotion].self, from: data) {
                emotions = decodeData
                print(#function, emotions)
            }
        }
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
            label.text = emotions[index].info
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
}
