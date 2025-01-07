//
//  SecondAdDetailViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class SecondAdDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    
    var adTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @objc func leftButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func setUI() {
        navigationItem.title = "광고 화면"
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = adTitle
    }
}
