//
//  ThirdTableViewCell.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    static var identifier = "ThirdTableViewCell"
    
    @IBOutlet private var baseView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var bookmarkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        baseView.backgroundColor = .systemGray6
        baseView.layer.cornerRadius = 10

        doneButton.isUserInteractionEnabled = true
        
        titleLabel.textColor = .black
        
        bookmarkButton.isUserInteractionEnabled = true
    }
    
    func configureData(row: Shopping, index: Int) {
        doneButton.tag = index
        doneButton.setImage(UIImage(systemName: row.done ? "checkmark.square" : "square")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
        
        titleLabel?.text = row.title
        
        bookmarkButton.tag = index
        bookmarkButton.setImage(UIImage(systemName: row.bookmark ? "star.fill" : "star")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
