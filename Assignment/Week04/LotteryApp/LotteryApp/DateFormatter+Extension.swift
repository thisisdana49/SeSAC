//
//  DateFormatter+Extension.swift
//  LotteryApp
//
//  Created by 조다은 on 1/14/25.
//

import Foundation

extension DateFormatter {
    static let krDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}

extension Date {
    func toFormattedString(_ dateFormat: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter.krDateFormatter
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }
}
