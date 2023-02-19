//
//  StockChartViewModelTests.swift
//  StockChartTests
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import XCTest
@testable import StockChart
import Combine

class StockChartViewModelTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    func test_search_called() {
        let expectation = XCTestExpectation(description: "test_search_called")
        let stockDatasourceMock = StockDataSourceMock()
        stockDatasourceMock.stockDataResult = .success(
            [
                .init(date: Date(), volume: 0, open: 0, close: 0, adjclose: 0, low: 0, high: 0),
                .init(date: Date(), volume: 0, open: 0, close: 0, adjclose: 0, low: 0, high: 0)
            ]
        )
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = "Bitcoin"
        
        viewModel.$stockData
            .dropFirst()
            .sink { data in
                XCTAssert(stockDatasourceMock.searchCalled == true)
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_search_failed_no_search_info() {
        let expectation = XCTestExpectation(description: "test_search_failed_no_search_info")
        let stockDatasourceMock = StockDataSourceMock()
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(stockDatasourceMock.searchCalled == false)
    }
    
    func test_search_success() {
        let expectation = XCTestExpectation(description: "test_search_failed_no_search_info")
        let stockDatasourceMock = StockDataSourceMock()
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = "Bitcoin"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(stockDatasourceMock.searchCalled == true)
        XCTAssert(stockDatasourceMock.searchCount == 1)
    }
    
    func test_time_frame_search_count_action() {
        let expectation = XCTestExpectation(description: "test_time_frame_search_count_action")
        let stockDatasourceMock = StockDataSourceMock()
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = "Bitcoin"
        viewModel.selectedTimeFrame = .threeMonths
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(stockDatasourceMock.searchCalled == true)
        XCTAssert(stockDatasourceMock.searchCount == 2)
    }
    
    func test_data() {
        let expectation = XCTestExpectation(description: "test_data")
        let stockDatasourceMock = StockDataSourceMock()
        stockDatasourceMock.stockDataResult = .success(
            [
                .init(date: Date(), volume: 1, open: 5, close: 10, adjclose: 6, low: 30, high: 15),
                .init(date: Date(), volume: 2, open: 10, close: 13, adjclose: 3, low: 15, high: 25)
            ]
        )
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = "Bitcoin"
        
        viewModel.$stockData
            .dropFirst()
            .sink { data in
                XCTAssert(stockDatasourceMock.searchCalled == true)
                XCTAssert(data.count == 2)
                XCTAssert(data.first == 10)
                XCTAssert(data.last == 13)
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_name_of_stock() {
        let expectation = XCTestExpectation(description: "test_name_of_stock")
        let stockDatasourceMock = StockDataSourceMock()
        stockDatasourceMock.stockDataResult = .success(
            [
                .init(date: Date(), volume: 1, open: 5, close: 10, adjclose: 6, low: 30, high: 15),
                .init(date: Date(), volume: 2, open: 10, close: 13, adjclose: 3, low: 15, high: 25)
            ]
        )
        stockDatasourceMock.searchDataResult = .success(SearchData(symbol: "AAPL", name: "Apple"))
        
        let viewModel = setupViewModel(dataSource: stockDatasourceMock)
        
        viewModel.searchText = "Bitcoin"
        
        viewModel.$stockName
            .dropFirst()
            .sink { stockName in
                XCTAssert(stockName == "Apple")
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func setupViewModel(dataSource: StockDataSource) -> StockChartViewModel {
        StockChartViewModel(
            stockDataUseCase: StockChartUseCaseImpl(dataSource: dataSource)
        )
    }
}
