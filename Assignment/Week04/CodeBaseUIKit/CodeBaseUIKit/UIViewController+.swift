//
//  UIViewController+.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/14/25.
//

import Foundation

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
