//
//  SecondTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    static var identifier = "SecondTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }

    override func prepareForReuse() {
        travelImageView.image = .no
    }
    
    private func configure() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .darkGray
        
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descLabel.textColor = .systemGray
        
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 8
    }
    
    func configureData(row: Travel) {
        titleLabel.text = row.title
            
        descLabel.text = row.description
        setStarsLabel(from: row.grade!, to: gradeLabel)
        setFormattedNumberLabel(from: row.save!, to: saveLabel)
        
        if let imgURL = URL(string: row.travel_image!) {
            travelImageView.kf.setImage(with: imgURL)
        } else {
            travelImageView.image = .no
        }
        
        likeButton.setImage(UIImage(systemName: row.like! ?  "heart" : "heart.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
    }
                
    func setStarsLabel(from doubleValue: Double, to label: UILabel) {
        let randomNum = String(Int.random(in: 1...2000))
        let starCount = Int(round(doubleValue))
        let yellowStars = NSAttributedString(string: String(repeating: "★", count: starCount), attributes: [.foregroundColor: UIColor.pointYellow])
        
        let remaingCount = max(5 - starCount, 0)
        let grayStarts = NSAttributedString(string: String(repeating: "★", count: remaingCount), attributes: [.foregroundColor: UIColor.systemGray6, .font: UIFont.systemFont(ofSize: 15)])
        
        let reviewCount = " (\(randomNum))"
        let reviewString = NSAttributedString(string: reviewCount, attributes: [.foregroundColor: UIColor.systemGray3, .font: UIFont.systemFont(ofSize: 15)])
        
        let combinedStars = NSMutableAttributedString()
        combinedStars.append(yellowStars)
        combinedStars.append(grayStarts)
        combinedStars.append(reviewString)
        
        label.attributedText = combinedStars
    }

    func setFormattedNumberLabel(from intValue: Int, to label: UILabel) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedSave = numberFormatter.string(for: intValue) ?? ""
        
        let saveString = NSAttributedString(string: "· 저장 \(formattedSave)", attributes: [.foregroundColor: UIColor.systemGray3, .font: UIFont.systemFont(ofSize: 15)])
        
        label.attributedText = saveString
    }
}
