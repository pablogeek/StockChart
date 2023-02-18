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
   
    func stockData(
        identifier: String,
        timeFrame: TimeFrame
    ) -> Future<[StockData], StockDataSourceError> {
        Future { future in
            SwiftYFinance.chartDataBy(
                identifier: identifier,
                start: timeFrame.startDate,
                end: timeFrame.endDate,
                interval: timeFrame.interval
            ) { dataChart, error in
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
    
    func search(term: String) -> Future<SearchData, StockDataSourceError> {
        Future { future in
            SwiftYFinance.fetchSearchDataBy(
                searchTerm: term,
                quotesCount: 1
            ) { result, error in
                if let error {
                    future(.failure(.fetchingError(error)))
                    return
                }
                
                guard let symbol = result?.first?.symbol else {
                    future(.failure(.dataNull))
                    return
                }
                
                let value = SearchData(symbol: symbol)
                future(.success(value))
            }
        }
    }
}


fileprivate extension TimeFrame {
    var interval: ChartTimeInterval {
        switch self {
        case .oneDay: return .onehour
        case .oneWeek: return .oneday
        case .oneMonth: return .oneday
        case .threeMonths: return .oneday
        case .oneYear: return .onemonths
        case .fiveYears: return .onemonths
        }
    }
}
