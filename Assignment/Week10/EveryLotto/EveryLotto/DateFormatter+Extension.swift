//
//  DateFormatter+Extension.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import Foundation

extension DateFormatter {
    static let krDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    static func getDateFormatter() -> DateFormatter {
        return krDateFormatter
    }
}

extension Date {
    func toFormattedString(_ dateFormat: String, format: String = "yyyy-MM-hh") -> String {
        let dateFormatter = DateFormatter.getDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ dateString: String, format: String = "yyyy-MM-dd") -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }
}
