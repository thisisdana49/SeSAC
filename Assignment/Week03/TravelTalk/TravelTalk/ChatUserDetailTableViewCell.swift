//
//  ChatUserDetailTableViewCell.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatUserDetailTableViewCell: UITableViewCell {
    static let identifier = "ChatUserDetailTableViewCell"

    @IBOutlet var dateSeperatorLabel: UILabel!
    @IBOutlet var dateSeperatorView: UIView!
    
    @IBOutlet var messageBaseView: UIView!
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        dateSeperatorView.isHidden = true
        dateSeperatorLabel.textColor = .white
        dateSeperatorLabel.backgroundColor = .black.withAlphaComponent(0.3)
        dateSeperatorLabel.layer.cornerRadius = 12
        dateSeperatorLabel.clipsToBounds = true
        dateSeperatorLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        messageBaseView.layer.cornerRadius = 15
        messageBaseView.backgroundColor = .systemGray6
        messageBaseView.layer.borderWidth = 1
        messageBaseView.layer.borderColor = UIColor.systemGray.cgColor
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .systemGray3
        dateLabel.textAlignment = .right
    }

    func configureData(date: String, message: String, dayChange: Bool, dateSeparator: String) {
        dateLabel.text = date
        messageLabel.text = message
        if dayChange {
            dateSeperatorView.isHidden = false
            dateSeperatorLabel.text = "  \(dateSeparator)  "
        } else {
            dateSeperatorView .isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
