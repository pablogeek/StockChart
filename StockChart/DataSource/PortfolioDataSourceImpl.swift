//
//  PortfolioDataSourceImpl.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 18/02/2023.
//

import Foundation
import Combine

class PortfolioDataSourceImpl: PortfolioDataSource {
    
    private let host = "https://run.mocky.io"
    
    private var subscriptions = Set<AnyCancellable>()
    
    private enum Endpoints: String {
        case portfolio = "/v3/2b63ba43-6440-4780-aa13-91e6d8247305"
    }
    
    func portfolioData() -> Future<[PortfolioStock], PortfolioAPIError> {
        Future { future in
            guard let url = URL(string: "\(self.host)\(Endpoints.portfolio.rawValue)") else {
                future(.failure(.wrongUrl))
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { output -> Data in
                        return output.data
                    }
                    .decode(type: PortfolioAPIData.self, decoder: JSONDecoder())
                    .mapError { error in
                        return error
                    }
                    .eraseToAnyPublisher()
                    .sink { completion in
                        switch completion {
                        case .finished: break
                        case let .failure(error):
                            future(.failure(.requestError(error)))
                        }
                    } receiveValue: { portfolioData in
                        future(.success(portfolioData.stocks
                            .map {
                                PortfolioStock(
                                    symbol: $0.symbol,
                                    companyName: $0.companyName,
                                    avgPrice: $0.avgPrice,
                                    quantity: $0.quantity,
                                    ltp: $0.ltp
                                )
                            }
                        ))
                    }.store(in: &self.subscriptions)
        }
    }
}
