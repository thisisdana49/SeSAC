//
//  MainTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    static let identifier = "FirstTableViewCell"
    
    @IBOutlet private var mainImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 20
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.lineBreakStrategy = .hangulWordPriority
        
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subTitleLabel.textColor = .systemGray2
        
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .systemGray3
    }
    
    func configureData(row: Magazine) {
        if let img = URL(string: row.photo_image) {
            mainImageView.kf.setImage(with: img)
        } else {
            mainImageView.image = .no
        }

        titleLabel.text = row.title
        subTitleLabel.text = row.subtitle

        let formatedDate = formatStringToDateString(row.date)
        dateLabel.text = formatedDate
    }
    
    func formatStringToDateString(_ date: String) -> String {
        let dateArray = Array(date)
        let formatedDate = "\(dateArray[0])\(dateArray[1])년 \(dateArray[2])\(dateArray[3])월 \(dateArray[4])\(dateArray[5])일"
        return formatedDate
    }


}
