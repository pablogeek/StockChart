//
//  ContentView.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import SwiftUI
import SwiftUICharts

struct StockChartView: View {
    
    @ObservedObject var viewModel = StockChartViewModel()
    
    @State var customText = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField(
                "Enter Something",
                text: $viewModel.searchText
            )
            .frame(height: 30)
            .padding(.leading, 5)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            // Stock info
            StockHeaderInfo(
                stockName: $viewModel.stockName,
                currentPrice: $viewModel.stockData.last ?? .constant(0)
            )
            .font(.title)
            
            // Stock Chart
            LineView(data: viewModel.stockData)
                .frame(maxHeight: 300)
            
            // Time frame buttons
            HStack(alignment: .top) {
                ForEach(TimeFrame.allCases, id: \.rawValue) { timeFrame in
                    Button(action: {
                        self.viewModel.selectedTimeFrame = timeFrame
                    }) {
                        Text(timeFrame.displayName)
                            .lineLimit(1)
                            .padding(5)
                            .foregroundColor(self.viewModel.selectedTimeFrame == timeFrame ? .white : .blue)
                            .background(self.viewModel.selectedTimeFrame == timeFrame ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct StockHeaderInfo: View {

    @Binding var stockName: String?
    @Binding var currentPrice: Double
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(stockName ?? "---")
            Text("$\(currentPrice, specifier: "%.2f")")
        }
    }
}

struct StockChartView_Previews: PreviewProvider {
    static var previews: some View {
        StockChartView()
    }
}
