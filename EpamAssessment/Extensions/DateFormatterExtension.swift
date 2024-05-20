//
//  DateFormatterExtension.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import Foundation

extension DateFormatter {
    static let iso8601DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
}
