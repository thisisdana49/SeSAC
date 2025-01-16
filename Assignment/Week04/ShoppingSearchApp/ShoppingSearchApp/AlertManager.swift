//
//  UIAlertController+Extensions.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    private init() { }
    
    func showAlert(title: String? = "오류 알림", message: String?, onConfirm: @escaping ()->(), over viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
            onConfirm()
        }))
        viewController.present(ac, animated: true)
    }
    
}
