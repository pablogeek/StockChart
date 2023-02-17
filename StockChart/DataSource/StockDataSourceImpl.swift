//
//  StockDataSourceImpl.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import SwiftYFinance
import Combine

class StockDataSourceImpl: StockDataSource {
   
    func stockData(identifier: String) -> Future<[StockData], StockDataSourceError> {
        Future { future in
            let startDate = Date().addingTimeInterval(-60 * 60 * 24 * 7) // 1 week ago
            let endDate = Date()
            
            SwiftYFinance.chartDataBy(identifier: identifier, start: startDate, end: endDate) { dataChart, error in
                if let error {
                    future(.failure(.fetchingError(error)))
                    return
                }
                
                guard let dataChart else {
                    future(.failure(.dataNull))
                    return
                }
                
                let data = dataChart.map { StockData(date: $0.date, volume: $0.volume, open: $0.open, close: $0.close, adjclose: $0.adjclose, low: $0.low, high: $0.high) }
                future(.success(data))
            }
        }
    }
}
