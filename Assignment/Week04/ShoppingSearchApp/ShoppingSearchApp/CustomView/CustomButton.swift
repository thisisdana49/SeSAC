//
//  CustomButtonView.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String, tag: Int) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(self.isSelected ? .black : .white, for: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.tag = tag
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
