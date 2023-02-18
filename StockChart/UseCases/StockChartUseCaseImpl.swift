//
//  StockChartUseCaseImpl.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine

class StockChartUseCaseImpl: StockChartUseCase {
    
    private let dataSource: StockDataSource
    
    init(dataSource: StockDataSource) {
        self.dataSource = dataSource
    }
    
    func stockData(
        term: String,
        timeFrame: TimeFrame
    ) -> AnyPublisher<StockData, StockDataSourceError> {
        guard !term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return Fail(error: StockDataSourceError.searchTermEmpty).eraseToAnyPublisher()
        }
        return dataSource
            .search(term: term)
            .flatMap { [unowned self] searchData in
                self.dataSource.stockData(
                    identifier: searchData.symbol,
                    timeFrame: timeFrame
                ).map {
                    StockData(data: $0, name: searchData.name)
                }
            }
            .eraseToAnyPublisher()
    }
}
