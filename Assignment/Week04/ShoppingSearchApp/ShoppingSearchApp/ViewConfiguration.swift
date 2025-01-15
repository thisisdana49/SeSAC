//
//  ViewConfiguration.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
