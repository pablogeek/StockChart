//
//  StockChartUseCaseImpl.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine


/// Normally we would use this class to combine and transform different api calls, in this case its just like a bridge
class StockChartUseCaseImpl: StockChartUseCase {
    
    private let dataSource: StockDataSource
    
    init(dataSource: StockDataSource) {
        self.dataSource = dataSource
    }
    
    func stockData(identifier: String) -> Future<[StockData], StockDataSourceError> {
        dataSource.stockData(identifier: identifier)
    }
}
