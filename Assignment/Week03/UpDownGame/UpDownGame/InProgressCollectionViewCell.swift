//
//  InProgressCollectionViewCell.swift
//  UpDownGame
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class InProgressCollectionViewCell: UICollectionViewCell {
    static let identifier = "InProgressCollectionViewCell"
    
    @IBOutlet var baseView: UIView!
    
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func isTriggered(isSelected: Bool) {
        baseView.backgroundColor = isSelected ? .white : .black
        contentLabel.textColor = isSelected ? .black : .white
    }
}
