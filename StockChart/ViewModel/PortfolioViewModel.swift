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
    
    @Published var overallModel = OverallViewModel(
        pAndLOverall: 0,
        pAndLPercentOverall: 0,
        pAndLOverallToday: 0,
        pAndLPercentOverallToday: 0
    )
    
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
            let totalInvested = portfolioData.totalInvested
            let pLOverall = portfolioData.pLOverall
            let pAndLToday = portfolioData.pAndLToday
            
            self?.overallModel = OverallViewModel(
                pAndLOverall: pLOverall,
                pAndLPercentOverall: (pLOverall / totalInvested) * 100,
                pAndLOverallToday: pAndLToday,
                pAndLPercentOverallToday: (pAndLToday / totalInvested) * 100
            )
            
            // Set portfolio stocks list
            self?.portfolioStocks = portfolioData
        }.store(in: &subscriptions)
    }
    
    struct OverallViewModel {
        let pAndLOverall: Double
        let pAndLPercentOverall: Double
        let pAndLOverallToday: Double
        let pAndLPercentOverallToday: Double
    }
}
