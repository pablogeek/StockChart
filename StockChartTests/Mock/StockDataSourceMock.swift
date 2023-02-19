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
    var stockDataResult: Result<[StockChart.StockData.Value], StockChart.StockDataSourceError>
    = .failure(.dataNull)
    func stockData(identifier: String, timeFrame: StockChart.TimeFrame) -> Future<[StockChart.StockData.Value], StockChart.StockDataSourceError> {
        Future { future in
            future(self.stockDataResult)
        }
    }
    
    private(set) var searchCalled: Bool = false
    private(set) var searchCount: Int = 0
    var searchDataResult: Result<StockChart.SearchData, StockChart.StockDataSourceError>
    = .success(StockChart.SearchData(symbol: "", name: ""))
    func search(term: String) -> Future<StockChart.SearchData, StockChart.StockDataSourceError> {
        searchCalled = true
        searchCount += 1
        return Future { future in
            future(self.searchDataResult)
        }
    }
}
