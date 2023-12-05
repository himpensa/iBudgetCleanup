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
    @State private var path = [Budget]()


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(budgets) { budget in
                    NavigationLink(value: budget) {
                        VStack(alignment: .leading) {
                            Text(budget.budget_name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteBudget)

            }
            .navigationTitle("Budgets")
            .navigationDestination(for: Budget.self, destination: EditBudgetView.init)

            .toolbar {
                Button("Add Budget", systemImage: "plus", action: addBudget)
            }
        }
    }
    

    
    func addBudget() {
        let budget = Budget()
        modelContext.insert(budget)
        path = [budget]
    }
    
    func deleteBudget(_ indexSet: IndexSet) {
        for index in indexSet {
            let budget = budgets[index]
            modelContext.delete(budget)
        }
    }
}



#Preview {
    ListCategoriesView()
}
