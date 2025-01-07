//
//  SecondDetailViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit
import Kingfisher

class SecondDetailViewController: UIViewController {
    var travel: Travel?
    
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        travelImageView.layer.cornerRadius = 15
        if let imgURL = travel?.travel_image, let img = URL(string: imgURL) {
            travelImageView.kf.setImage(with: img)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.text = travel?.title
        
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        descLabel.text = travel?.description
        
        popButton.layer.cornerRadius = popButton.frame.height / 2
        popButton.tintColor = .pointBlue
        popButton.setTitleColor(.white, for: .normal)
        popButton.setTitle("다른 관광지 보러 가기", for: .normal)
    }
}
