//
//  ChatListCollectionViewCell.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChatListCollectionViewCell"
    
    @IBOutlet var roomImageView: UIImageView!
    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var roomDateLabel: UILabel!
    @IBOutlet var roomMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
