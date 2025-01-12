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
        
        configure()
    }
    
    private func configure() {
        roomImageView.contentMode = .scaleAspectFill
        
        roomNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        roomDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        roomDateLabel.textColor = .systemGray4
        roomDateLabel.textAlignment = .right
        
        roomMessageLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        roomMessageLabel.textColor = .systemGray2
    }
    
    func configureData(image: String, name: String, date: String, message: String) {
        roomImageView.image = UIImage(named: image)
        roomNameLabel.text = name
        roomDateLabel.text = date
        roomMessageLabel.text = message
    }
}
