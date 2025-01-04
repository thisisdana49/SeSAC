//
//  SecondTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var detailInfoLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
