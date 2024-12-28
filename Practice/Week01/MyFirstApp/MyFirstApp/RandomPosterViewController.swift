//
//  RandomPosterViewController.swift
//  MyFirstApp
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

// button tap -> random image
class RandomPosterViewController: UIViewController {
    
    // Outlet: Property, UI 속성 조절 시 사용
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var sampleLabel: UILabel!
    @IBOutlet var sampleButton: UIButton!
    
    let number = Int.random(in: 1...5)
    
    // 사용자 눈에 화면이 뜨기 직전에 실행 되는 기능
    // 스토리보드 상에서 구현하기 어려운 디자인(모서리 둥글기 등)
    // 보는 중에 모서리가 둥글어지면 이상하니까 미리 설정!
    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.backgroundColor = UIColor(named: "pointColor")
        posterImageView.contentMode = .scaleAspectFit
        
        sampleButton.setTitle("load random", for: UIControl.State.normal)
        sampleButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        sampleButton.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        sampleButton.layer.cornerRadius = 10
        sampleButton.layer.borderColor = UIColor.black.cgColor
        
        sampleLabel.clipsToBounds = false
        sampleLabel.numberOfLines = 2
        sampleLabel.textAlignment = .center
        sampleLabel.text = "Tap the button to load random image!"
        sampleLabel.textColor = .red
        sampleLabel.font = .boldSystemFont(ofSize: 20)
        sampleLabel.layer.cornerRadius = 10
        sampleLabel.layer.borderWidth = 1
        sampleLabel.layer.borderColor = UIColor.black.cgColor
        sampleLabel.layer.backgroundColor = UIColor.yellow.cgColor
    }
    

    @IBAction func sampleButtonClicked(_ sender: UIButton) {
        let number = Int.random(in: 1...5)
        
        print(number, self.number)
        
        posterImageView.image = UIImage(named: "\(number)")
    }
}
