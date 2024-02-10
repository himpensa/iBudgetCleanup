//
//  SimpleTransactionsPerCategoryView.swift
//  iBudget
//
//  Created by Antoine Himpens on 23/01/2024.
//

import SwiftUI
import Charts

struct SimpleTransactionsPerCategoryView: View {
    let data = [
        (name: "Cachapa", sales: 9631),
        (name: "Crêpe", sales: 959),
        (name: "Injera", sales: 4891),
        (name: "Jian Bing", sales: 2506),
        (name: "American", sales: 1777),
        (name: "Dosa", sales: 625),
    ]


    var body: some View {
        Chart(data, id: \.name) { name, sales in
            SectorMark(
                angle: .value("Value", sales),
                innerRadius: .ratio(0.618),
                //outerRadius: .inset(10),
                angularInset: 1
            )
            .cornerRadius(4)
            .foregroundStyle(by: .value("Product category", name))
        }
    }
    
  }



#Preview {
        
    SimpleTransactionsPerCategoryView()
}
