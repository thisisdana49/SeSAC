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
        setupButton(title: title, tag: tag)
    }
    
    private func setupButton(title: String, tag: Int) {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.configuration?.baseForegroundColor = .black
                button.configuration?.baseBackgroundColor = .white
            default:
                button.configuration?.baseBackgroundColor = .black
                button.configuration?.baseForegroundColor = .white
            }
        }
        
        var config = UIButton.Configuration.filled()
        
        config.title = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        
        config.background.strokeColor = .white
        config.background.strokeWidth = 1
        
        self.tag = tag
        
        configurationUpdateHandler = handler
        configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton(title: "", tag: 0)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
