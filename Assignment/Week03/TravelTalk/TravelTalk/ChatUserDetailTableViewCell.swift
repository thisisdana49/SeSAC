//
//  ChatUserDetailTableViewCell.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatUserDetailTableViewCell: UITableViewCell {
    static let identifier = "ChatUserDetailTableViewCell"

    @IBOutlet var messageBackgroundView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        messageBackgroundView.layer.cornerRadius = 15
        messageBackgroundView.backgroundColor = .systemGray6
        messageBackgroundView.layer.borderWidth = 1
        messageBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .systemGray3
        dateLabel.textAlignment = .right
    }

    func configureData(date: String, message: String) {
        dateLabel.text = date
        messageLabel.text = message
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
