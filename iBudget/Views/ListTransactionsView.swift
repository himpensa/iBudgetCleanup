import SwiftUI
import SwiftData

struct ListTransactionsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Transaction.transaction_date, order: .reverse) var transactions: [Transaction]
    @Query var accounts: [Account]
    @State private var path = [Transaction]()
    @State private var lastDate = DateFormatter().date(from: "2020/01/01") ?? Date()
    @State private var selectedAccount: Account? = nil
    
    private var groupedTransactions: [Date: [Transaction]] {
        var groupedDict = Dictionary(grouping: filteredTransactions, by: { Calendar.current.startOfDay(for: $0.transaction_date) })
        groupedDict = groupedDict.mapValues { $0.sorted(by: { $0.transaction_date > $1.transaction_date }) }
        return groupedDict
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedTransactions.sorted(by: { $0.key > $1.key }), id: \.key) { date, transactionsForDate in
                    Section(header: Text(dateFormatted(date))) {
                        ForEach(transactionsForDate, id: \.self) { transaction in
                            NavigationLink(destination: EditTransactionView(transaction: transaction)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: transaction.transaction_category?.category_icon ?? "questionmark.circle")
                                        Text(transaction.transaction_details)
                                            .font(.headline)
                                        Spacer()
                                        Text(String(format: "%.2f", transaction.transaction_amount))
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteTransaction)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: accountPicker)
            .toolbar {
                Button("Add Transaction", systemImage: "plus", action: addTransaction)
            }
            .onAppear {
                let defaultAccount = accounts.first { $0.account_is_default }
            }
        }
    }

    private func header(for index: Int) -> Text {
        let transaction = filteredTransactions[index]
        print(dateFormatted(transaction.transaction_date))
        return Text(dateFormatted(transaction.transaction_date))
    }

    private var accountPicker: some View {
        Picker(selection: $selectedAccount, label: Text("Account")) {
            ForEach(accounts, id: \.self) { account in
                Text(account.account_name).tag(account as Account?)
            }
        }
        .onAppear {
            // Sélectionner automatiquement le compte par défaut si selectedAccount est nil
            if selectedAccount == nil {
                selectedAccount = accounts.first { $0.account_is_default }
            }
        }
    }

    private func dateFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

    private func addTransaction() {
        let transaction = Transaction()
        transaction.transaction_account = selectedAccount
        modelContext.insert(transaction)
        path = [transaction]
    }

    private func deleteTransaction(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            modelContext.delete(transaction)
        }
    }

    private var filteredTransactions: [Transaction] {
        if let selectedAccount = selectedAccount {
            return transactions.filter { $0.transaction_account == selectedAccount }
        } else {
            return transactions
        }
    }
}

struct ListTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        ListTransactionsView()
    }
}
