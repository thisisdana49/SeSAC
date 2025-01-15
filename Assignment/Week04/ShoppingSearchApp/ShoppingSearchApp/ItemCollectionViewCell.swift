//
//  ItemCollectionViewCell.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import Kingfisher
import SnapKit

class ItemCollectionViewCell: UICollectionViewCell, ViewConfiguration {
    static let id = "ItemCollectionViewCell"

    let thumbnailImageView = UIImageView()
    let mallNameLabel = UILabel()
    let titleLabel =  UILabel()
    let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(item: ItemDetail) {
        if let image = URL(string: item.image) {
            thumbnailImageView.kf.setImage(with: image)
        }
        mallNameLabel.text = item.mallName
        titleLabel.text = item.title
        priceLabel.text = Int(item.lprice)?.formatted(.number)
    }

    internal func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    internal func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
        }
    }
    
    internal func configureView() {
        contentView.backgroundColor = .black
        
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        
        mallNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        mallNameLabel.textColor = .white
        titleLabel.textColor = .white
        priceLabel.textColor = .white
        
        titleLabel.numberOfLines = 2
    }
    
}
