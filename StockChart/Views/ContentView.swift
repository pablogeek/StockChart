//
//  ContentView.swift
//  StockChart
//
//  Created by Pablo Martinez Piles on 17/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StockChartView()
                .tabItem {
                    Image(systemName: "pencil.and.outline")
                    Text("Chart")
                }
            
            PortfolioView()
                .tabItem {
                    Image(systemName: "filemenu.and.selection")
                    Text("Portfolio")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
