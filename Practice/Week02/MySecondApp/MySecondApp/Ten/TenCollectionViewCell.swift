//
//  TenCollectionViewCell.swift
//  MySecondApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class TenCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.backgroundColor = .brown
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.masksToBounds = true
    }

}
