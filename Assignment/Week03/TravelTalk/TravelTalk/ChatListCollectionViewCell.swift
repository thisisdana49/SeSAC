//
//  ChatListCollectionViewCell.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChatListCollectionViewCell"
    
    @IBOutlet var groupChatImageView: UIView!
    @IBOutlet var normalChatImageView: UIImageView!
    @IBOutlet var chatNameLabel: UILabel!
    @IBOutlet var chatDateLabel: UILabel!
    @IBOutlet var chatMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        normalChatImageView.contentMode = .scaleAspectFit
        
//        for (index, subView) in groupChatImageView.subviews.enumerated() {
//            guard let imageView = subView as? UIImageView else { continue }
//            
//            imageView.layer.cornerRadius = imageView.frame.height / 2
//            imageView.layer.borderColor = UIColor.systemGray5.cgColor
//            imageView.layer.borderWidth = 1
//        }
        
        chatNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        chatDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        chatDateLabel.textColor = .systemGray4
        chatDateLabel.textAlignment = .right
        
        chatMessageLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        chatMessageLabel.textColor = .systemGray2
    }
    
    func configureData(image: [String], name: String, date: String, message: String) {
        if image.count == 1 {
            normalChatImageView.isHidden = false
            groupChatImageView.isHidden = true
            normalChatImageView.image = UIImage(named: image[0])
        } else {
            normalChatImageView.isHidden = true
            groupChatImageView.isHidden = false
            for (index, subView) in groupChatImageView.subviews.enumerated() {
                guard let imageView = subView as? UIImageView else { continue }
                
                if index < image.count {
                    imageView.image = UIImage(named: image[index])
                    imageView.isHidden = false
                } else {
                    imageView.isHidden = true
                }
            }
        }
        chatNameLabel.text = name
        chatDateLabel.text = date
        chatMessageLabel.text = message
    }
}
