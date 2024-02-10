//
//  SimpleBudgetChart.swift
//  iBudget
//
//  Created by Antoine Himpens on 24/01/2024.
//

import SwiftUI
import Charts
import SwiftData


struct SimpleBudgetLineChartItemView: View {
    var budgetChartValues: [BudgetChartValue]
    var title: String
    var budgetLimit: Double
    
    
    init(budget : Budget) {
        self.title = budget.budget_name
        self.budgetLimit = budget.budget_limit
        self.budgetChartValues = [
            .init(name: "Spent", value: 50),
            .init(name: "Planned", value: 30),
            .init(name: "Remaining", value: 50),
        ]
    }
    
    var body: some View {
        HStack {
            Text(title)
            Text("78.1€ of " + String(budgetLimit) + "€ Used")
        }
        Chart{
            ForEach(budgetChartValues) { item in
                BarMark(
                    x: .value("Name", item.value),
                    y: .value("Budget", "Budget"),
                    stacking: .center)
                .foregroundStyle(by: .value("Name", item.name))
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Budget.self, configurations: config)

    let sampleCategory = Category(category_name: "Restaurant", category_icon: "questionmark.circle", parentID: nil)

    let sampleBudget = Budget(budget_name: "Crédit immobilier", budget_end_date: .now, budget_limit: 1326, budget_interval: .month, budget_category: sampleCategory)

    return SimpleBudgetLineChartItemView(budget: sampleBudget)
        .modelContainer(container)
}

