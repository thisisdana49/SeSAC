//
//  ThirdTableViewCell.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class ThirdTableViewCell: UITableViewCell {

    let stackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 12
        
        return stackView
    }()
    
    let rankingLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        
        return label
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(rankingLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        rankingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankingLabel.snp.trailing).offset(20)
            make.width.equalTo(stackView.snp.width).dividedBy(2)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(stackView.snp.width).dividedBy(4)
        }
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLabel.textColor = .white
        dateLabel.textColor = .white
    }
}

#Preview {
    ThirdTableViewCell()
}
