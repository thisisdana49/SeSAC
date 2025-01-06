//
//  FourTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit
import Kingfisher

class FourTableViewCell: UITableViewCell {
    static let identifier = "FourTableViewCell"
    
    @IBOutlet var entireView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var bottomLineView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configure() {
        entireView.clipsToBounds = true
        entireView.layer.cornerRadius = 25
        entireView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        bottomLineView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        cityImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.textAlignment = .right
        cityNameLabel.textColor = .white
        cityNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
        cityExplainLabel.layer.opacity = 1.0
        cityExplainLabel.textColor = .white
        cityExplainLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }

    func configureData(row: City) {
        cityNameLabel.text = row.city_full_name
        cityExplainLabel.text = row.city_explain
        
        if let imgURL = URL(string: row.city_image) {
            cityImageView.kf.setImage(with: imgURL)
        } else {
            cityImageView.image = .no
        }
    }
    
}
