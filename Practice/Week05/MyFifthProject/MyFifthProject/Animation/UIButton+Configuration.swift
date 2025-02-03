//
//  UIButton+Configuration.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/31/25.
//

import UIKit

extension UIButton.Configuration {
    
    static func customStyle() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        config.title = "로그인하기"
        config.subtitle = "환영합니다"
        config.image = UIImage(systemName: "star")
        
        return config
    }
    
}
