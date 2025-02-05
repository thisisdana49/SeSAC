//
//  ViewController.swift
//  MVVMProject
//
//  Created by 조다은 on 2/5/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyVC = CurrencyViewController()
        let wordCounterVC = WordCounterViewController()
        let userVC = UserViewController()
        
        currencyVC.tabBarItem = UITabBarItem(title: "EXCHANGE", image: UIImage(systemName: "dollarsign.arrow.circlepath"), tag: 0)
        wordCounterVC.tabBarItem = UITabBarItem(title: "WORD COUNTER", image: UIImage(systemName: "keyboard.chevron.compact.down"), tag: 1)
        wordCounterVC.tabBarItem = UITabBarItem(title: "USER", image: UIImage(systemName: "person.3"), tag: 2)
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        let navCurrencyVC = UINavigationController(rootViewController: currencyVC)
        let navWordCounterVC = UINavigationController(rootViewController: wordCounterVC)
        let navUserVC = UINavigationController(rootViewController: userVC)
        
        setViewControllers([navCurrencyVC, navWordCounterVC, navUserVC], animated: false)
    }

}

