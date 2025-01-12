//
//  ChatDetailTableViewCell.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatDetailTableViewCell: UITableViewCell {
    static let identifier = "ChatDetailTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var messageBackgroundView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        profileImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        messageBackgroundView.layer.cornerRadius = 15
        messageBackgroundView.backgroundColor = .white
        messageBackgroundView.layer.borderWidth = 1
        messageBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .systemGray3
    }
    
    func configureData(image: String, name: String, date: String, message: String) {
        profileImageView.image = UIImage(named: image)
        nameLabel.text = name
        dateLabel.text = date
        messageLabel.text = message
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
