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
    
    
    
}
