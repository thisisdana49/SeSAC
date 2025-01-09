//
//  SampleCollectionViewCell.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    static let identifier = "SampleCollectionViewCell"
    @IBOutlet var descImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // layoutIfNeeded
//    override func layoutIfNeeded() {
//        <#code#>
//    }
    
    // layoutSubviews
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        descImageView.layer.cornerRadius = descImageView.frame.width / 2
//    }
}
