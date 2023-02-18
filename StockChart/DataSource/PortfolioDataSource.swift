//
//  PortfolioDataSource.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import Combine

enum PortfolioAPIError: Error {
    case wrongUrl
    case requestError(Error)
}

protocol PortfolioDataSource {
    func portfolioData() -> Future<[PortfolioStock], PortfolioAPIError>
}
