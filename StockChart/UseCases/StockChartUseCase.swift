//
//  StockChartUseCase.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine

protocol StockChartUseCase {
    func stockData(identifier: String) -> Future<[StockData], StockDataSourceError>
}
