//
//  StockDataSourceMock.swift
//  StockChartTests
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
@testable import StockChart
import Combine

class StockDataSourceMock: StockDataSource {
    
    var stockDataResult: Result<[StockChart.StockData], StockChart.StockDataSourceError> = .failure(.dataNull)
    func stockData(identifier: String, timeFrame: StockChart.TimeFrame) -> Future<[StockChart.StockData], StockChart.StockDataSourceError> {
        Future { future in
            future(self.stockDataResult)
        }
    }
    
    private(set) var searchCalled: Bool = false
    func search(term: String) -> Future<StockChart.SearchData, StockChart.StockDataSourceError> {
        searchCalled = true
        return Future { future in
            future(.success(StockChart.SearchData(symbol: "")))
        }
        
    }
    
    
}
