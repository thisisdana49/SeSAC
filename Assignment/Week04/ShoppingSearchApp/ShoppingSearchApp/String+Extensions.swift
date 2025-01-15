//
//  String+Extensions.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import Foundation

extension String {
    func cleanedTag() -> String {
        return self.replacingOccurrences(of: "<b>", with: "")
                   .replacingOccurrences(of: "</b>", with: "")
    }
}
