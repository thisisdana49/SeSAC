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
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var versionButton: UIButton!
    
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

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        saveEmotionData(isReset: true)
        setEmotionButtonUI()
    }
    
    func saveEmotionData(isReset: Bool = false) {
        let encoder = JSONEncoder()
        
        if isReset {
            self.emotions = EmotionInfo().emotions
        }
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
        
        // reset button
        resetButton.isUserInteractionEnabled = true
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .black
        resetButton.layer.cornerRadius = 5
        resetButton.setTitle("Reset Data", for: .normal)
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
        
        versionButton.setTitle("Go to version 2", for: .normal)
        versionButton.setTitleColor(.white, for: .normal)
        versionButton.backgroundColor = .black
        versionButton.layer.cornerRadius = 5
    }
}
