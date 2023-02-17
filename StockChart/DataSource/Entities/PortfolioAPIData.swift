//
//  PortfolioAPIData.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation

struct PortfolioAPIData: Decodable {
    let stocks: [Stock]
    
    struct Stock: Decodable {
        let symbol: String
        let companyName: String
        let avgPrice: Double
        let quantity: Double
        let ltp: Double
    }
}
