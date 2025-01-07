//
//  SecondVersionViewController.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class SecondVersionViewController: UIViewController {
    let keyIdentifier = "emotionVer2"
    var emotions = EmotionInfo().emotions
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hamburgerMenuImage: UIImageView!
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEmotionData()
        setUI()
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        emotions[index].degree += 1
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
            label.text = emotions[index].info
            label.textAlignment = .center
        }
    }
    
    func setUI() {
        setTopBarUI()
        setEmotionButtonUI()
        
        view.backgroundColor = .primary
    }
}
