//
//  UITextField+Extension.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit

//extension UITextField {
//    func addBottomBorder() {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 2)
//        bottomLine.backgroundColor = UIColor.white.cgColor
//        borderStyle = .none
//        layer.addSublayer(bottomLine)
//        layer.masksToBounds = true
//    }
//}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
//            print("check",frame.width)
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
