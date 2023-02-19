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
            PortfolioOverallView(overallModel: $viewModel.overallModel)
                .listRowSeparator(.visible)
                .listRowSeparatorTint(.white)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 5)
                        .background(.clear)
                        .foregroundColor(.secondary)
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10
                            )
                        )
                )
            
            ForEach(viewModel.portfolioStocks, id: \.symbol) { stock in
                PortfolioItemView(stock: stock)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(.clear)
                            .foregroundColor(.secondary)
                            .padding(
                                EdgeInsets(
                                    top: 2,
                                    leading: 10,
                                    bottom: 2,
                                    trailing: 10
                                )
                            )
                    )
            }
        }
        .background(Color.primary)
        .listStyle(.plain)
    }
}

struct PortfolioItemView: View {
    let stock: PortfolioStock

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.companyName)
                    .font(.headline)
                Text("Invested \(stock.totalInvested, specifier: "%.2f")")
                    .font(.subheadline)
                Text("Quantity \(stock.quantity, specifier: "%.2f")")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(stock.pAndL, specifier: "%.2f") (\(stock.pAndLPercent, specifier: "%.2f") %)")
                    .font(.headline)
                Text("\(stock.avgPrice, specifier: "%.2f") Avg")
                    .font(.subheadline)
                Text("\(stock.ltp, specifier: "%.2f") LTP")
                    .font(.subheadline)
            }
        }
        .foregroundColor(.white)
        .padding(
            EdgeInsets(
                top: 15,
                leading: 5,
                bottom: 15,
                trailing: 5
            )
        )
    }
}


struct PortfolioOverallView: View {
    
    @Binding var overallModel: PortfolioViewModel.OverallViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total performance \(overallModel.pAndLOverall, specifier: "%.2f")")
                    .font(.headline)
                Text("*Till last day \(overallModel.pAndLPercentOverall, specifier: "%.2f") %")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(overallModel.pAndLOverallToday, specifier: "%.2f")")
                    .font(.headline)
                Text("\(overallModel.pAndLPercentOverallToday, specifier: "%.2f") %")
                    .font(.subheadline)
            }
        }
        .padding(5)
        .foregroundColor(.white)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
