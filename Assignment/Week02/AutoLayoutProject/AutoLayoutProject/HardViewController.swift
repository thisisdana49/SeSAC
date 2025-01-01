//
//  HardViewController.swift
//  AutoLayoutProject
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class HardViewController: UIViewController {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var giftButton: UIButton!
    @IBOutlet var qrCodeButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var editLabel: UILabel!
    @IBOutlet var storyButton: UIButton!
    @IBOutlet var storyLabel: UILabel!
    @IBOutlet var testStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        closeButton.setImage(UIImage(systemName: "xmark"), for:.normal)
        giftButton.setImage(UIImage(systemName: "gift"), for: .normal)
        qrCodeButton.setImage(UIImage(systemName: "qrcode"), for: .normal)
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        
        chatButton.setImage(UIImage(systemName: "bubble.fill"), for: .normal)
        chatLabel.text = "나와의 채팅"
        
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editLabel.text = "프로필 편집"
        
        storyButton.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        storyLabel.text = "카카오스토리"
    }
}
