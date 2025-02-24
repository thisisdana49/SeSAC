//
//  CustomLabel.swift
//  EveryLotto
//
//  Created by 조다은 on 2/25/25.
//

import UIKit

final class CustomLabel: UILabel {

    override var text: String? {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    private func setupStyle() {
        self.textAlignment = .center
        self.textColor = .white
        self.clipsToBounds = true
    }
    
    private func updateAppearance() {
        guard let text = self.text, let number = Int(text) else {
            self.backgroundColor = .clear
            return
        }
        
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
