//
//  CustomSearchBar.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.tintColor = .lightGray
        
        if let textField = self.value(forKey: "searchField") as? UITextField, let leftView = textField.leftView as? UIImageView {
            textField.backgroundColor = .darkGray
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(
                string: "브랜드, 상품, 프로필, 태그 등",
                attributes: [.foregroundColor: UIColor.lightGray]
            )
            
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
