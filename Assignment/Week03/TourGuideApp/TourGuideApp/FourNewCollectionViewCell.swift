//
//  FourNewCollectionViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class FourNewCollectionViewCell: UICollectionViewCell {
    static let identifier = "FourNewCollectionViewCell"
    var city: City?
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    private func configure() {
        print(#function)
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameLabel.text = city?.city_full_name
        
        explainLabel.textAlignment = .center
        explainLabel.textColor = .darkGray
        explainLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        explainLabel.text = city?.city_explain
    }
}
