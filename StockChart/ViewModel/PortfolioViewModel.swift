//
//  PortfolioViewModel.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
import Combine
import SwiftUI

class PortfolioViewModel: ObservableObject {
    @Published var portfolioStocks: [PortfolioStock] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let portfolioUseCase: PortfolioUseCase
    
    init(portfolioUseCase: PortfolioUseCase = PortfolioUseCaseImpl(dataSource: PortfolioDataSourceImpl())) {
        self.portfolioUseCase = portfolioUseCase
        bindEvents()
    }
    
    private func bindEvents() {
        portfolioUseCase.portfolioData().sink { [weak self] completion in
            switch completion {
            case .failure(_):
                self?.portfolioStocks = []
            case .finished: break
            }
        } receiveValue: { [weak self] portfolioData in
            self?.portfolioStocks = portfolioData
        }.store(in: &subscriptions)
    }
}
