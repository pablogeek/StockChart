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
    
    var portfolioDataResult: Result<[StockChart.PortfolioStock], StockChart.PortfolioAPIError> = .success([])
    func portfolioData() -> Future<[StockChart.PortfolioStock], StockChart.PortfolioAPIError> {
        Future { future in
            future(self.portfolioDataResult)
        }
    }
}
