//
//  PortfolioDataSource.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation

protocol PortfolioDataSource {
    func portfolioData() -> [PortfolioStock]
}
