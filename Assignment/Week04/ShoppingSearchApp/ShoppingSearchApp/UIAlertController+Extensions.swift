//
//  UIAlertController+Extensions.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "오류 알림", message: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAciton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAciton)
        present(alert, animated: true)
    }
}
