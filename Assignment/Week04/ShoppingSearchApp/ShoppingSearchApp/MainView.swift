//
//  MainView.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let mainImageView = UIImageView()
    let mainLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(mainImageView)
        addSubview(mainLabel)
    }
    
    override func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        
        mainImageView.image = .main
        mainImageView.contentMode = .scaleAspectFit
        
        mainLabel.text = "정말로 쇼핑하고 시퍼요"
        mainLabel.textColor = .white
        mainLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
}
