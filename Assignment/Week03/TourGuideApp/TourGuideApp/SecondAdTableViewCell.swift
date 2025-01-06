//
//  SecondAdTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/5/25.
//

import UIKit

class SecondAdTableViewCell: UITableViewCell {
    static var identifier = "SecondAdTableViewCell"
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }

    private func configure() {
        self.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        let colors: [UIColor] = [.pointPink, .pointGreen]
        let color = colors.randomElement()
        baseView.backgroundColor = color
        baseView.layer.cornerRadius = 10
        
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        badgeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .white
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.layer.masksToBounds = true
        badgeLabel.text = "AD"
    }
    
    func configureData(row: Travel) {
        contentLabel.text = row.title
    }
}
