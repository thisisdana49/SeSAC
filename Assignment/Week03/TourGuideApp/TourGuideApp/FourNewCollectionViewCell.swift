//
//  FourNewCollectionViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit
import Kingfisher

class FourNewCollectionViewCell: UICollectionViewCell {
    static let identifier = "FourNewCollectionViewCell"
    var city: City?
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        print(#function, city)
        configure()
    }

    private func configure() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        explainLabel.numberOfLines = 0
        explainLabel.textAlignment = .center
        explainLabel.textColor = .darkGray
        explainLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func configureData(in row: City) {
        if let imgURL = URL(string: row.city_image) {
            cityImageView.kf.setImage(with: imgURL)
        } else {
            cityImageView.image = .no
        }
        nameLabel.text = row.city_full_name
        explainLabel.text = row.city_explain
    }
}
