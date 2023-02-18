//
//  StockChartUseCase.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine

protocol StockChartUseCase {
    func stockData(term: String) -> AnyPublisher<[StockData], StockDataSourceError>
}
