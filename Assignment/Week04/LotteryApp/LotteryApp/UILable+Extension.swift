//
//  UILable+Extension.swift
//  LotteryApp
//
//  Created by 조다은 on 1/14/25.
//

import UIKit

extension UILabel {
    
    func setOwnColor() {
        let number = Int(self.text ?? "0") ?? -1
        switch number {
        case 1...10:    self.backgroundColor = .systemYellow
        case 11...20:   self.backgroundColor = .systemBlue
        case 21...30:   self.backgroundColor = .systemRed
        case 31...40:   self.backgroundColor = .systemGray
        case 41...45:   self.backgroundColor = .systemGreen
        default:        self.backgroundColor = .clear
        }
    }
    
}
