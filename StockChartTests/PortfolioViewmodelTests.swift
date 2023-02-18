//
//  PortfolioViewmodelTests.swift
//  StockChartTests
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import XCTest
@testable import StockChart

class PortfolioViewmodelTests: XCTest {
    
    func test_successPortfolio() {
        let mockDataSource = PortfolioDataSourceMock()
        mockDataSource.stocks = [
            PortfolioStock(symbol: "AAPL", companyName: "Apple Inc.", avgPrice: 130.50, quantity: 100, ltp: 143.76),
            PortfolioStock(symbol: "GOOGL", companyName: "Alphabet Inc.", avgPrice: 2350.00, quantity: 50, ltp: 2351.18),
            PortfolioStock(symbol: "MSFT", companyName: "Microsoft Corporation", avgPrice: 240.00, quantity: 75, ltp: 246.23)
        ]
        let useCase = PortfolioUseCaseImpl(dataSource: mockDataSource)
        let viewModel = PortfolioViewModel(portfolioUseCase: useCase)
        
        
    }
}
