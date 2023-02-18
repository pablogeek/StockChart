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
    @Published var stockName: String?
    
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var searchSubscriptionCancellable: AnyCancellable?
    
    private let stockDataUseCase: StockChartUseCase
    
    @Published var selectedTimeFrame = TimeFrame.oneWeek
    
    init(stockDataUseCase: StockChartUseCase = StockChartUseCaseImpl(dataSource: StockDataSourceImpl())) {
        self.stockDataUseCase = stockDataUseCase
        self.binding()
    }
    
    /// Bind selectedTimeFrame and searchText
    private func binding() {
        $selectedTimeFrame
            .receive(on: DispatchQueue.global())
            .sink { [weak self] timeFrame in
                guard let self else { return }
                self.search(text: self.searchText, timeFrame: timeFrame)
            }
            .store(in: &subscriptions)
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .sink(receiveValue: { [weak self] t in
                guard let self else { return }
                self.search(text: t, timeFrame: self.selectedTimeFrame)
            } )
            .store(in: &subscriptions)
    }
    
    private func search(
        text: String,
        timeFrame: TimeFrame
    ) {
        // This cancels the current search if any
        searchSubscriptionCancellable?.cancel()
        searchSubscriptionCancellable = nil
        
        searchSubscriptionCancellable =  stockDataUseCase.stockData(
            term: text,
            timeFrame: timeFrame
        )
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        /*.tryMap {
            $0.compactMap { $0.close }
        }
        .tryMap {
            $0.map { Double($0) }
        }*/
        .sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure:
                self?.stockData = []
                self?.stockName = nil
            }
        } receiveValue: { [weak self] stockData in
            self?.stockData = stockData.data.compactMap { $0.close }.compactMap { Double($0) }
            self?.stockName = stockData.name
        }
    }
}
