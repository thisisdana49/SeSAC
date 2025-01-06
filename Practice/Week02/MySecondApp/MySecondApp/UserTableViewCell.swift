//
//  UserTableViewCell.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    // 프로퍼티도 다른 곳에서 쓰이지 않도록 최적화
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var aliasLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    // Nib from Xib, 즉 스토리보드로 구현했을 때만 실행이 됨
    // 따라서 모든 경우에 실행되지 X
    override func awakeFromNib() {
        // 절대 달라지지 않는 UI
        super.awakeFromNib()
        
        configure()
    }
    
    override func prepareForReuse() {
        print(#function)
        // reuse 되고있던 찌꺼기를 정리해주는 작업
        profileImageView.image = UIImage(systemName: "person.fill")
    }
    
    // 바깥에서 부를 일이 없는 친구, . 찍어도 나오지 않게 하려면 접근 제어자로 연결고리를 끊어놓자
    private func configure() {
        aliasLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        statusLabel.numberOfLines = 0
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    func configureData(row: Friends) {
        // 그런데 각 cell의 value는 달라도 UI는 동일하지 않나?
        // 매번 컨베이어 벨트가 돌 때마다 정해줄 필요가 있나?
        print(#function)
        let friend = row
        
        let imageUrl = friend.profile_image
        if let imageUrl {
            let url = URL(string: imageUrl)
            profileImageView.kf.setImage(with: url)
        }
//        else {ㅌ
        
        aliasLabel.text = friend.name
        statusLabel.text = friend.message
        
        likeButton.setImage(UIImage(systemName: friend.like ? "heart.fill" : "heart"), for: .normal)
    }
}
