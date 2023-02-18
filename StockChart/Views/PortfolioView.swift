//
//  Portfolio.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @ObservedObject var viewModel = PortfolioViewModel()
    
    var body: some View {
        List {
            PortfolioOverallView(
                pAndLTotal: $viewModel.pAndLOverall,
                pAndLTotalPercent: $viewModel.pAndLPercentOverall,
                pAndLToday: $viewModel.pAndLOverallToday,
                pAndLPercentToday: $viewModel.pAndLPercentOverallToday
            )
            
            ForEach(viewModel.portfolioStocks, id: \.symbol) { stock in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.companyName)
                            .font(.headline)
                        Text("Invested \(stock.totalInvested, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Quantity \(stock.quantity, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(stock.pAndL, specifier: "%.2f") (\(stock.pAndLPercent, specifier: "%.2f") %)")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(stock.avgPrice, specifier: "%.2f") Avg")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(stock.ltp, specifier: "%.2f") LTP")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}


struct PortfolioOverallView: View {
    
    @Binding var pAndLTotal: Double
    @Binding var pAndLTotalPercent: Double
    @Binding var pAndLToday: Double
    @Binding var pAndLPercentToday: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total performance \(pAndLTotal, specifier: "%.2f")")
                    .font(.headline)
                Text("*Till last day \(pAndLTotalPercent, specifier: "%.2f") %")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(pAndLToday, specifier: "%.2f")")
                    .font(.headline)
                Text("\(pAndLPercentToday, specifier: "%.2f") %")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
