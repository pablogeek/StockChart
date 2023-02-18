//
//  TimeFrame.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation

enum TimeFrame: String, CaseIterable {
    case oneDay = "1D"
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonths = "3M"
    case oneYear = "1Y"
    case fiveYears = "5Y"
    
    var startDate: Date {
        switch self {
        case .oneDay:
            return Date().addingTimeInterval(-86400) // 24 hours ago
        case .oneWeek:
            return Date().addingTimeInterval(-60 * 60 * 24 * 7)
        case .oneMonth:
            return Calendar.current.date(byAdding: .month, value: -1, to: Date())! // 1 month ago
        case .threeMonths:
            return Calendar.current.date(byAdding: .month, value: -3, to: Date())! // 3 months ago
        case .oneYear:
            return Calendar.current.date(byAdding: .year, value: -1, to: Date())! // 1 year ago
        case .fiveYears:
            return Calendar.current.date(byAdding: .year, value: -5, to: Date())!
        }
    }
    
    var endDate: Date {
        return Date()
    }
    
    var displayName: String {
        rawValue
    }
}
