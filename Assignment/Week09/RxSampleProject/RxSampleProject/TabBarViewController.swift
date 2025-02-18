//
//  TabBarViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/19/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = SimpleTableViewExampleViewController()
        let secondVC = NumbersViewController()
        let thirdVC = SimpleValidationViewController()
        let fourthVC = BirthdayViewController()
        
        firstVC.tabBarItem = UITabBarItem(title: "ONE", image: UIImage(systemName: "1.square"), selectedImage: UIImage(systemName: "1.square.fill"))
        secondVC.tabBarItem = UITabBarItem(title: "TWO", image: UIImage(systemName: "2.square"), selectedImage: UIImage(systemName: "2.square.fill"))
        thirdVC.tabBarItem = UITabBarItem(title: "THREE", image: UIImage(systemName: "3.square"), selectedImage: UIImage(systemName: "3.square.fill"))
        fourthVC.tabBarItem = UITabBarItem(title: "FOUR", image: UIImage(systemName: "4.square"), selectedImage: UIImage(systemName: "4.square.fill"))
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        setViewControllers([firstVC, secondVC, thirdVC, fourthVC], animated: false)
    }

}
