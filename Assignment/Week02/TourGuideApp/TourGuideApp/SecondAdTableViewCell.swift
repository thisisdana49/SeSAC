//
//  SecondAdTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/5/25.
//

import UIKit

class SecondAdTableViewCell: UITableViewCell {

    @IBOutlet var baseView: UIView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
