//
//  HardViewController.swift
//  AutoLayoutProject
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class HardViewController: UIViewController {

    @IBOutlet var backgroundImageVIew: UIImageView!
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
        backgroundImageVIew.contentMode = .scaleAspectFill
        backgroundImageVIew.clipsToBounds = true
        backgroundImageVIew.image = .backgroundProfile
        
        closeButton.setImage(UIImage(systemName: "xmark")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for:.normal)
        giftButton.setImage(UIImage(systemName: "gift")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        qrCodeButton.setImage(UIImage(systemName: "qrcode")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        settingsButton.setImage(UIImage(systemName: "gearshape")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
    
        backgroundImageVIew.contentMode = .scaleAspectFill
        
        profileImageView.image = .profile
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        
        chatButton.setImage(UIImage(systemName: "bubble.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        chatLabel.text = "나와의 채팅"
        
        editButton.setImage(UIImage(systemName: "pencil")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        editLabel.text = "프로필 편집"
        
        storyButton.setImage(UIImage(systemName: "quote.closing")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        storyLabel.text = "카카오스토리"
    }
}
