//
//  PortfolioDataSourceMock.swift
//  StockChartTests
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
@testable import StockChart
import Combine

class PortfolioDataSourceMock: PortfolioDataSource {
    var stocks: [PortfolioStock] = []
    func portfolioData() -> Future<[StockChart.PortfolioStock], StockChart.PortfolioAPIError> {
        Future { future in
            future(.success(self.stocks))
        }
    }
}
