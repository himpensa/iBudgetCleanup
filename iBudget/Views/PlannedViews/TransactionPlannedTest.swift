import SwiftUI
import SwiftData

struct TransactionListView: View {
    let transactions: [Transaction]
    
    var body: some View {
        List(transactions) { transaction in
            VStack(alignment: .leading) {
                Text("Date: \(formattedDate(for: transaction.transaction_date))")
                Text("Amount: \(transaction.transaction_amount, specifier: "%.2f")")
                Text("Description: \(transaction.transaction_details)")
            }
        }
    }

    private func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Category.self, Transaction.self, Planned.self, configurations: config)
        
        let sampleCurrency = Currency(currency_name: "US Dollar", currency_symbol: "$", currency_alphabetic_code: "USD", currency_numeric_code: "840", currency_minor_unit: 2, currency_is_default: false)
        let sampleCategory = Category(category_name: "Restaurant", category_icon: "questionmark.circle", parentID: nil)
        let sampleAccount = Account(account_name: "Courant", account_description: "test", account_currency: nil, account_type: "Cash", starting_balance: 0, is_opened: true, account_is_default: false, transactions: [])
       
        let currentDate = Date()
        let plannedTransaction = Planned(planned_next_date: currentDate, planned_end_date: Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!, planned_recurrence: .monthly, planned_amount: 100.0, planned_description: "Sample Transaction", planned_currency: sampleCurrency, planned_account: sampleAccount, planned_category: sampleCategory)
        
        container.mainContext.insert(plannedTransaction)

        let transactions = plannedTransaction.generateTransactions()
        
        // Insérez chaque transaction dans le conteneur
        for transaction in transactions {
            container.mainContext.insert(transaction)
        }
        
        return TransactionListView(transactions: transactions)
        .modelContainer(container)
    }
}
