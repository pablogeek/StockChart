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
    
    @Published var pAndLOverall: Double = 0.0
    @Published var pAndLPercentOverall: Double = 0.0
    
    init(portfolioUseCase: PortfolioUseCase = PortfolioUseCaseImpl(dataSource: PortfolioDataSourceImpl())) {
        self.portfolioUseCase = portfolioUseCase
        binding()
    }
    
    private func binding() {
        portfolioUseCase.portfolioData().sink { [weak self] completion in
            switch completion {
            case .failure(_):
                self?.portfolioStocks = []
            case .finished: break
            }
        } receiveValue: { [weak self] portfolioData in
            // Calculate overall
            let totalInvested = portfolioData.map { $0.totalInvested }.reduce(0, +)
            
            let pLOverall = portfolioData.map { $0.currentValue }.reduce(0, +) - totalInvested
            
            self?.pAndLOverall = pLOverall
            self?.pAndLPercentOverall = (pLOverall / totalInvested) * 100
            
            // Set portfolio stocks list
            self?.portfolioStocks = portfolioData
        }.store(in: &subscriptions)
    }
}
