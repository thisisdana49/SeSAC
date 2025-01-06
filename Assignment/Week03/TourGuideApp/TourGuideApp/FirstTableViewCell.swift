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
    
    override func prepareForReuse() {
        mainImageView.image = .no
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
        let strToDate = DateFormatter()
        strToDate.dateFormat = "yyMMdd"
        let formattedDate = strToDate.date(from: date) ?? Date()
        
        let dateToFormattedStr = DateFormatter()
        dateToFormattedStr.dateFormat = "yy년 MM월 dd일"
        dateToFormattedStr.locale = Locale(identifier: "ko_KR")
        let formattedStr = dateToFormattedStr.string(from: formattedDate)
        
        print("결과", formattedDate)
        
        return formattedStr
    }
}
