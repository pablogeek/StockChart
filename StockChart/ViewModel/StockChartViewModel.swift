//
//  StockChartViewModel.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import Foundation
import SwiftUI
import Combine

class StockChartViewModel: ObservableObject {
    @Published var stockData: [Double] = []
    
    @Published var debouncedText = ""
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let stockDataUseCase: StockChartUseCase
    
    init(stockDataUseCase: StockChartUseCase = StockChartUseCaseImpl(dataSource: StockDataSourceImpl())) {
        self.stockDataUseCase = stockDataUseCase
        
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.debouncedText = t
                self?.search(text: t)
            } )
            .store(in: &subscriptions)
    }
    
    private func search(text: String) {
        // Make sure there is text
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        stockDataUseCase.stockData(identifier: text).receive(on: DispatchQueue.main).sink { _ in
            
        } receiveValue: { [weak self] data in
            self?.stockData = data
                .compactMap { $0.close }
                .compactMap { Double($0) }
        }.store(in: &subscriptions)
    }
}
