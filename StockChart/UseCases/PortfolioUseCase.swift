//
//  PortfolioUseCase.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
import Combine

protocol PortfolioUseCase {
    func portfolioData() -> Future<[PortfolioStock], PortfolioAPIError>
}
