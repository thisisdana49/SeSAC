//
//  UIViewController+.swift
//  LotteryApp
//
//  Created by 조다은 on 1/14/25.
//

import UIKit

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
