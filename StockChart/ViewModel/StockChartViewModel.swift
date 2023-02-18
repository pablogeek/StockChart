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
    
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let stockDataUseCase: StockChartUseCase
    
    init(stockDataUseCase: StockChartUseCase = StockChartUseCaseImpl(dataSource: StockDataSourceImpl())) {
        self.stockDataUseCase = stockDataUseCase
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .sink(receiveValue: { [weak self] t in
                self?.search(text: t)
            } )
            .store(in: &subscriptions)
    }
    
    private func search(text: String) {
        stockDataUseCase.stockData(term: text)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure:
                    self?.stockData = []
                }
            } receiveValue: { [weak self] data in
                self?.stockData = data
                    .compactMap { $0.close }
                    .compactMap { Double($0) }
            }.store(in: &subscriptions)
    }
}
