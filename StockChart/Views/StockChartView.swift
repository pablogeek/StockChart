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
        }
        .padding()
    }
}

struct StockChartView_Previews: PreviewProvider {
    static var previews: some View {
        StockChartView()
    }
}
