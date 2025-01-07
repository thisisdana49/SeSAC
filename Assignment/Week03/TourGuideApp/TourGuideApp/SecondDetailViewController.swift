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
    
    @objc func rightButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        navigationItem.title = "관광지 화면"
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 15
        if let imgURL = travel?.travel_image, let img = URL(string: imgURL) {
            travelImageView.kf.setImage(with: img)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.text = travel?.title
        
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        descLabel.text = travel?.description
        
        popButton.layer.cornerRadius = popButton.frame.height / 2
        popButton.backgroundColor = .pointBlue
        popButton.setTitleColor(.white, for: .normal)
        popButton.setTitle("다른 관광지 보러 가기", for: .normal)
    }
    
}
