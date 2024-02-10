//
//  SimpleBarChart.swift
//  iBudget
//
//  Created by Antoine Himpens on 23/01/2024.
//

import SwiftUI
import Charts

struct SimpleBarChart: View {
    let data: [(name: String, amount: Double)]
    
    @State private var xScrollPosition: Double = 0

    var body: some View {
        VStack {
            Chart(data, id: \.name) { name, amount in
                BarMark(x: PlottableValue.value("Day", name), y: PlottableValue.value("Amount", amount))
            }
            .chartScrollableAxes(.horizontal)
            .chartScrollTargetBehavior(.valueAligned(unit: 2))
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
    }
}
