//
//  FourTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import Kingfisher
import UIKit

class FourTableViewCell: UITableViewCell {
    static let identifier = "FourTableViewCell"

    @IBOutlet var entireView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var bottomLineView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
    }

    func configure() {
        entireView.layer.cornerRadius = 25
        entireView.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        entireView.layer.shadowColor = UIColor.black.cgColor
        entireView.layer.shadowOpacity = 0.3
        entireView.layer.shadowRadius = 5
        entireView.layer.shadowOffset = CGSize(width: 1, height: 1)
        entireView.layer.shadowPath = nil
        entireView.layer.masksToBounds = false

        bottomLineView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bottomLineView.layer.cornerRadius = 20
        bottomLineView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
        
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 25
        cityImageView.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)

        cityNameLabel.textAlignment = .right
        cityNameLabel.textColor = .white
        cityNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        cityExplainLabel.layer.opacity = 1.0
        cityExplainLabel.textColor = .white
        cityExplainLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }

    func configureData(row: City, searchText: String) {
        print(searchText)
        cityNameLabel.attributedText = highlightSearchText(
            in: row.city_full_name, searchText: searchText)
        cityExplainLabel.attributedText = highlightSearchText(
            in: row.city_explain, searchText: searchText)

        if let imgURL = URL(string: row.city_image) {
            cityImageView.kf.setImage(with: imgURL)
        } else {
            cityImageView.image = .no
        }
    }

    private func highlightSearchText(in text: String, searchText: String)
        -> NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(
            of: searchText, options: .caseInsensitive)

        if range.location != NSNotFound {
            attributedString.addAttribute(
                .foregroundColor, value: UIColor.systemYellow, range: range)
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(
                    ofSize: cityNameLabel.font.pointSize), range: range)
        }

        return attributedString
    }
}
