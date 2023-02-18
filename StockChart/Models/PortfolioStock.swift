//
//  PortfolioStock.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation

struct PortfolioStock {
    let symbol: String
    let companyName: String
    let avgPrice: Double
    let quantity: Double
    let ltp: Double
    
    
    var currentValue: Double {
        quantity * ltp
    }
    
    var totalInvested: Double {
        quantity * avgPrice
    }
    
    var pAndL: Double {
        currentValue - totalInvested
    }
    
    var pAndLPercent: Double {
        (pAndL / totalInvested) * 100
    }
}

/// Some overall calculations
extension [PortfolioStock] {
    var totalInvested: Double { map { $0.totalInvested }.reduce(0, +) }
    var pLOverall: Double { map { $0.currentValue }.reduce(0, +) - totalInvested }
    var pAndLToday: Double { map { $0.pAndL }.reduce(0, +) }
}
