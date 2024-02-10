//
//  BudgetReportsSummaryView.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/02/2024.
//

import SwiftUI
import SwiftData

struct SummaryBudgetReportView: View {
    let data = [
        (name: "01/01", amount: 12.3),
        (name: "02/01", amount: 4),
        (name: "03/01", amount: 6),
        (name: "04/01", amount: 2),
        (name: "05/01", amount: 7),
        (name: "06/01", amount: 0),
        (name: "07/01", amount: 2),
        (name: "08/01", amount: 0),
        (name: "09/01", amount: 3),
        (name: "10/01", amount: 4),
        (name: "11/01", amount: 5),
        (name: "12/01", amount: 4),
        (name: "13/01", amount: 0),
        (name: "14/01", amount: 3),
        (name: "15/01", amount: 0),
        (name: "16/01", amount: 2),
        (name: "17/01", amount: 0),
        (name: "18/01", amount: 3),
        (name: "19/01", amount: 0),
        (name: "20/01", amount: 0),
        (name: "21/01", amount: 3),
        (name: "22/01", amount: 4),
        (name: "23/01", amount: 5),
        (name: "24/01", amount: 0),
        (name: "25/01", amount: 10),
        (name: "26/01", amount: 0),
        (name: "27/01", amount: 4),
        (name: "28/01", amount: 0),
        (name: "29/01", amount: 4),
        (name: "30/01", amount: 0),
        (name: "31/01", amount: 2)
    ]
    var budget: Budget
    
    @State private var isShowingEditView = false // Etat pour contrôler la navigation

    
    var body: some View {
        NavigationStack {
            
            GroupBox() {
                SimpleBudgetLineChartItemView(budget: budget)
                SimpleBarChart(data: data)
            }
        }
        .navigationBarTitle(Text(budget.budget_name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            isShowingEditView = true // Définir l'état sur true pour afficher la vue d'édition
        }) {
            Text("Edit").bold()
        })
        .sheet(isPresented: $isShowingEditView) { // Utiliser sheet pour afficher la vue d'édition
              EditBudgetView(budget: budget)
          }
    }
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Budget.self, configurations: config)

    let sampleCategory = Category(category_name: "Restaurant", category_icon: "questionmark.circle", parentID: nil)

    let sampleBudget = Budget(budget_name: "Crédit immobilier", budget_end_date: .now, budget_limit: 1326, budget_interval: .month, budget_category: sampleCategory)

    container.mainContext.insert(sampleBudget)

    return SummaryBudgetReportView(budget: sampleBudget)
        .modelContainer(container)
}
