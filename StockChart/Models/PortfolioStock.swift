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


extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
