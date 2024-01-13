import SwiftUI
import SwiftData

struct EditBudgetView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var budget: Budget
    @State private var selectedDate = Date()
    @State private var selectedFrequency: Frequency = .month // Default to Month
    @State private var selectedCategories: [Category] = []
    @Query var categories: [Category]

    
    init(budget : Budget) {
        self._budget = Bindable(budget)
        self._selectedCategories = State(initialValue: budget.categories)
        }
    
    var body: some View {
        Form {
            Section(header: Text("Budget Title")) {
                TextField("Name", text: $budget.budget_name)
            }
            Section(header: Text("Frequency")) {
                Picker("Frequency", selection: $selectedFrequency) {
                    ForEach(Frequency.allCases, id: \.self) { frequency in
                        Text(frequency.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("End Date")) {
                DatePicker("End Date", selection: $budget.budget_end_date, displayedComponents: [.date])
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
                    .onChange(of: selectedCategories) { newValue in
                        print(newValue)
                        budget.categories = selectedCategories
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

enum Frequency: String, CaseIterable {
    case day = "Jour"
    case week = "Semaine"
    case month = "Mois"
    case year = "Année"
}

struct EditBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Budget.self, configurations: config)

        let sampleBudget = Budget(budget_name: "Crédit immobilier", budget_end_date: .now, budget_limit: 1326)

        return EditBudgetView(budget: sampleBudget)
            .modelContainer(container)
    }
}
