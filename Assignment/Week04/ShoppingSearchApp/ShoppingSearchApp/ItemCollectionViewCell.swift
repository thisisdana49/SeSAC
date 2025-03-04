//
//  ItemCollectionViewCell.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import Kingfisher
import SnapKit

class ItemCollectionViewCell: UICollectionViewCell {
    static let id = "ItemCollectionViewCell"

    let thumbnailImageView = UIImageView()
    let likeBaseView = UIView()
    let likeButton = CustomLikeButton()
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
    
    func configureData(item: Product) {
        if let image = URL(string: item.image) {
            thumbnailImageView.kf.setImage(with: image)
        }
        mallNameLabel.text = item.mallName
        titleLabel.text = item.title.cleanedTag()
        priceLabel.text = Int(item.lprice)?.formatted(.number)
        likeButton.setProductInfo(with: item)
        print("set product ID", item.productId)
    }

    internal func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(likeBaseView)
        likeBaseView.addSubview(likeButton)
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
        
        likeBaseView.snp.makeConstraints { make in
            make.size.equalTo(thumbnailImageView)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.size.equalTo(30)
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
        
        likeButton.setTitle("", for: .normal)
        likeButton.backgroundColor = .white
        likeButton.layer.cornerRadius = 15
        likeButton.isUserInteractionEnabled = true
        
        mallNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        mallNameLabel.textColor = .white
        titleLabel.textColor = .white
        priceLabel.textColor = .white
        
        titleLabel.numberOfLines = 2
    }
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
}
