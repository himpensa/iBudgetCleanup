//
//  ListBudgetsView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct ListBudgetsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var budgets: [Budget]
    @State private var showingSheet = false

    var body: some View {
        NavigationStack() {
            List {
                ForEach(budgets) { budget in
                    GroupBox() {
                        SimpleBudgetLineChartItemView(budget: budget)
                    }
                    .groupBoxStyle(PersoGroupBoxStyle(destination: SummaryBudgetReportView(budget: budget)))
                    
          }
                .onDelete(perform: deleteBudget)
            }
            .navigationTitle("Janvier")

            .toolbar {
                Button("Add Budget", systemImage: "plus") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    NewBudgetView(showingSheet: $showingSheet)
                }
            }
        }
    }

   

    func deleteBudget(_ indexSet: IndexSet) {
        for index in indexSet {
            let budget = budgets[index]
            modelContext.delete(budget)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Budget.self, configurations: config)

    let sampleCategory = Category(category_name: "Restaurant", category_icon: "questionmark.circle", parentID: nil)

    let sampleBudget = Budget(budget_name: "Crédit immobilier", budget_end_date: .now, budget_limit: 1326, budget_interval: .month, budget_category: sampleCategory)
    container.mainContext.insert(sampleBudget)
    
    return ListBudgetsView()
        .modelContainer(container)
}

