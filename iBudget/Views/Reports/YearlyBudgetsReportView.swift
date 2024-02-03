//
//  SimpleTransactionsPerCategoryView.swift
//  iBudget
//
//  Created by Antoine Himpens on 23/01/2024.
//

import SwiftUI
import Charts

struct YearlyBudgetsReportView: View {
    let data = [
        (name: "Janvier", amount: 12, total: 100),
        (name: "Février", amount: 4, total: 88),
        (name: "Mars", amount: 6, total: 82),
        (name: "Avril", amount: 2, total: 80),
        (name: "May", amount: 7, total: 73),
        (name: "Juin", amount: 0, total: 73),
        (name: "Juillet", amount: 2, total: 71),
        (name: "Aout", amount: 0, total: 71),
        (name: "Septembre", amount: 3, total: 68),
        (name: "Octobre", amount: 4, total: 64),
        (name: "Novembre", amount: 5, total: 59),
        (name: "Décembre", amount: 4, total: 55)
    ]
    
    
    var body: some View {
        Chart(data, id: \.name) { name, amount, total in
            BarMark(x: PlottableValue.value("Day", name), y: PlottableValue.value("Amount", amount))
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }
    
}


#Preview {
    YearlyBudgetsReportView()
}
