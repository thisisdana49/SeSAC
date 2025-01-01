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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    func setUI() {
        navigationItem.title = "대장님의 다마고치"
        
        profileEditButton.image = UIImage(systemName: "person.crop.circle")
        
        speechBubbleImageView.image = .bubble
        speechBubbleLabel.text = "대장님 만나서 반가워요!"
        
        tamagotchiImageView.image = ._2_1
        
        levelBadgeLabel.text = "방실방실 다마고치"
        detailStateLabel.text = "LV1 · 밥알 0개 · 물방울 0개"
        
        mealTextField.placeholder = "밥주세용"
        mealButton.setTitle("밥먹기", for: .normal)
        
        waterTextField.placeholder = "물주세용"
        waterButton.setTitle("물먹기", for: .normal)
    }
}

