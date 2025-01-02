//
//  UILabel+Extension.swift
//  MySecondApp
//
//  Created by 조다은 on 1/2/25.
//

import UIKit

extension UILabel {
    func setPrimaryLabel(_ text: String) {
        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .blue
        self.textAlignment = .center
        self.text = text
    }
}
