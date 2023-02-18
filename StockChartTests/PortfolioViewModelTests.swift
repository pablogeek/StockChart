//
//  PortfolioViewmodelTests.swift
//  StockChartTests
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import XCTest
@testable import StockChart
import Combine

class PortfolioViewModelTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    func test_successPortfolio() {
        let expectation = XCTestExpectation(description: "test_successPortfolio")
        
        let mockDataSource = PortfolioDataSourceMock()
        mockDataSource.portfolioDataResult = .success(
            [
                PortfolioStock(symbol: "AAPL", companyName: "Apple Inc.", avgPrice: 130.50, quantity: 100, ltp: 143.76),
                PortfolioStock(symbol: "GOOGL", companyName: "Alphabet Inc.", avgPrice: 2350.00, quantity: 50, ltp: 2351.18),
                PortfolioStock(symbol: "MSFT", companyName: "Microsoft Corporation", avgPrice: 240.00, quantity: 75, ltp: 246.23)
            ]
        )
        let useCase = PortfolioUseCaseImpl(dataSource: mockDataSource)
        let viewModel = PortfolioViewModel(portfolioUseCase: useCase)
        
        viewModel.$portfolioStocks.sink { stocks in
            XCTAssert(stocks.count == 3)
            XCTAssert(stocks.last?.symbol == "MSFT")
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_errorPortfolio() {
        let expectation = XCTestExpectation(description: "test_errorPortfolio")
        
        let mockDataSource = PortfolioDataSourceMock()
        mockDataSource.portfolioDataResult = .failure(.wrongUrl)
        let useCase = PortfolioUseCaseImpl(dataSource: mockDataSource)
        let viewModel = PortfolioViewModel(portfolioUseCase: useCase)
        
        viewModel.$portfolioStocks.sink { stocks in
            XCTAssert(stocks.count == 0)
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_overall_values() {
        let expectation = XCTestExpectation(description: "test_successPortfolio")
        
        let portFolioValues = [
            PortfolioStock(symbol: "AAPL", companyName: "Apple Inc.", avgPrice: 130.50, quantity: 100, ltp: 143.76),
            PortfolioStock(symbol: "GOOGL", companyName: "Alphabet Inc.", avgPrice: 2350.00, quantity: 50, ltp: 2351.18),
            PortfolioStock(symbol: "MSFT", companyName: "Microsoft Corporation", avgPrice: 240.00, quantity: 75, ltp: 246.23)
        ]
        
        let mockDataSource = PortfolioDataSourceMock()
        mockDataSource.portfolioDataResult = .success(portFolioValues)
        let useCase = PortfolioUseCaseImpl(dataSource: mockDataSource)
        let viewModel = PortfolioViewModel(portfolioUseCase: useCase)
        
        viewModel.$overallModel.sink { overallModel in
            let totalInvested = portFolioValues.map { $0.totalInvested }.reduce(0, +)
            let pLOverall = portFolioValues.map { $0.currentValue }.reduce(0, +) - totalInvested
            let pAndLToday = portFolioValues.map { $0.pAndL }.reduce(0, +)
            XCTAssert(portFolioValues.totalInvested == totalInvested)
            XCTAssert(portFolioValues.pLOverall == pLOverall)
            XCTAssert(portFolioValues.pAndLToday == pAndLToday)
            
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
