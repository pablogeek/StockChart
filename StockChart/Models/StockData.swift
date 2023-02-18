//
//  StockData.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation

struct StockData {
    let data: [Value]
    let name: String
    
    struct Value {
        let date: Date?
        let volume: Int?
        let open: Float?
        let close: Float?
        let adjclose: Float?
        let low: Float?
        let high: Float?
    }
}
