//
//  MenuView.swift
//  iBudget
//
//  Created by Antoine Himpens on 06/01/2024.
//


import SwiftUI
import SwiftData

struct EditBudgetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var budget: Budget
    @State private var selectedDate = Date()
    @State private var selectedNumber: Int
    @State private var selectedInterval: Interval = .month // Default to Month
    @State private var selectedCategory: Category
    @Query var categories: [Category]

    
    init(budget : Budget) {
        self._budget = Bindable(budget)
        self._selectedCategory = State(initialValue: budget.budget_category)
        self._selectedInterval = State(initialValue: budget.budget_interval)
        self._selectedNumber = State(initialValue: budget.budget_number)
        }
    
    var body: some View {
        NavigationStack{
        Form {
            Section(header: Text("Budget Title")) {
                TextField("Name", text: $budget.budget_name)
            }
            Section(header: Text("Recurrence")) {
                HStack {
                    Picker("Tous les ", selection: $selectedNumber) {
                                    ForEach(1 ..< 11) { number in
                                        Text("\(number)")
                                    }
                                }
                    Picker("", selection: $selectedInterval) {
                        ForEach(Interval.allCases, id: \.self) { interval in
                            Text(interval.rawValue)
                        }
                    }
                }
            }
        
            Section(header: Text("Start Date")) {
                VStack {
                DatePicker("Start Date", selection: $budget.budget_start_date, displayedComponents: [.date])
 //                       .onChange(of: budget.budget_start_date) { _ in
   //                         budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
     //                   }
                DatePicker("End Date", selection: $budget.budget_end_date, displayedComponents: [.date])
            }
        }
                Section(header: Text("Budget Limit")) {
                    TextField("Limit", value: $budget.budget_limit, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category.category_name).tag(category as Category?)
                        }
                    }
                }
                .onChange(of: selectedCategory) { newCategory, _ in
                    budget.budget_category = newCategory
                }
            

  /*          .onChange(of: selectedInterval) { newInterval, _ in
                budget.budget_interval = newInterval
                budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
            }
            .onChange(of: selectedNumber) { newRecurrence, _ in
                budget.budget_number = newRecurrence+1
                budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
            }

        
*/        }
        .navigationBarTitle(Text("Edit Budget"), displayMode: .inline)
          .navigationBarItems(trailing: Button(action: {
              // TODO : missing the code to discard the changes. Probably full rework needed
              dismiss()
                          }) {
                              Text("Done").bold()
                          })
        }
    
    }
}


