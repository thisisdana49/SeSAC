//
//  UserTableViewCell.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var aliasLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configureData(row: Friends) {
        let friend = row
        
        let imageUrl = friend.profile_image
        if let imageUrl {
            let url = URL(string: imageUrl)
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.fill")
        }
        
        aliasLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        aliasLabel.text = friend.name
        
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.text = friend.message
        
        likeButton.setImage(UIImage(systemName: friend.like ? "heart.fill" : "heart"), for: .normal)
    }
}
