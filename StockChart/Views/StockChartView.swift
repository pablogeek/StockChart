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
        VStack {
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
            
            LineView(data: viewModel.stockData)
            
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
        }
        .padding()
    }
}

struct StockChartView_Previews: PreviewProvider {
    static var previews: some View {
        StockChartView()
    }
}
