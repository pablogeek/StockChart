//
//  StockDataSource.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine

enum StockDataSourceError: Error {
    case fetchingError(Error)
    case parseError
    case dataNull
}

protocol StockDataSource {
    func stockData(identifier: String) -> Future<[StockData], StockDataSourceError>
}
