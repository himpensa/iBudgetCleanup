import SwiftUI
import SwiftData

struct EditBudgetView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var budget: Budget
    @State private var selectedDate = Date()
    @State private var selectedNumber: Int
    @State private var selectedInterval: Interval = .month // Default to Month
    @State private var selectedCategories: [Category] = []
    @Query var categories: [Category]

    
    init(budget : Budget) {
        self._budget = Bindable(budget)
        self._selectedCategories = State(initialValue: budget.categories)
        self._selectedInterval = State(initialValue: budget.budget_interval)
        self._selectedNumber = State(initialValue: budget.budget_number)
        }
    
    var body: some View {
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
     /*       .onChange(of: selectedInterval) { newInterval, _ in
                budget.budget_interval = newInterval
                budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
            }
            .onChange(of: selectedNumber) { newRecurrence, _ in
                budget.budget_number = newRecurrence+1
                budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
            }
       */
            Section(header: Text("Start Date")) {
                VStack {
                DatePicker("Start Date", selection: $budget.budget_start_date, displayedComponents: [.date])
            /*            .onChange(of: budget.budget_start_date) { _ in
                            budget.calculateEndDate(startDate: budget.budget_start_date, interval: selectedInterval, numberOfRecurrences: selectedNumber+1)
                        }*/
                DatePicker("End Date", selection: $budget.budget_end_date, displayedComponents: [.date])
            }
        }
        
            Section(header: Text("Budget Limit")) {
                TextField("Limit", value: $budget.budget_limit, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            Section(header: Text("Categories")) {
                List {
                    ForEach(categories, id: \.self) { category in
                        MultipleSelectionRow(title: category.category_name, isSelected: selectedCategories.contains(category)) {
                            if selectedCategories.contains(category) {
                                selectedCategories.removeAll(where: { $0 == category })
                            } else {
                                selectedCategories.append(category)
                            }
                        }
                    }
                    .onChange(of: selectedCategories) { newValue, _ in
                        budget.categories = newValue
                    }
                }
            }
        }
        .navigationTitle("Edit Budget")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: isSelected ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture(perform: action)
        }
    }
}



struct EditBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Budget.self, configurations: config)

        let sampleBudget = Budget(budget_name: "Crédit immobilier", budget_end_date: .now, budget_limit: 1326, budget_number: 2 , budget_interval: .day)

        return EditBudgetView(budget: sampleBudget)
            .modelContainer(container)
    }
}
