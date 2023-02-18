//
//  PortfolioUseCaseImpl.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
import Combine

/// Normally we would use this class to combine and transform different api calls, in this case its just like a bridge
class PortfolioUseCaseImpl: PortfolioUseCase {
    
    let dataSource: PortfolioDataSource
    
    init(dataSource: PortfolioDataSource) {
        self.dataSource = dataSource
    }
    
    func portfolioData() -> Future<[PortfolioStock], PortfolioAPIError> {
        dataSource.portfolioData()
    }
}
