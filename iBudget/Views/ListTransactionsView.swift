//
//  ListTransactionsView.swift
//  iBudget
//
//  Created by Antoine Himpens on 02/12/2023.
//

import SwiftUI
import SwiftData

struct ListTransactionsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Transaction.transaction_date) var transactions: [Transaction]
    @Query var accounts: [Account]
    @State private var path = [Transaction]()
    @State private var lastDate = DateFormatter().date(from: "2020/01/01") ?? Date()
    @State private var selectedAccount: Account? = nil

    init() {
            let defaultAccount = accounts.first { $0.is_default }
            _selectedAccount = State(initialValue: defaultAccount)
    }

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredTransactions, id: \.self) { transaction in
                    NavigationLink(destination: EditTransactionView(transaction: transaction)) {
                    VStack {
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
                .onDelete(perform: deleteTransaction)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: accountPicker)
        .toolbar {
            Button("Add Account", systemImage: "plus", action: addTransaction)
        }
    }
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
                selectedAccount = accounts.first { $0.is_default }
            }
        }
    }

    
    // Calcul des transactions filtrées en fonction du compte sélectionné
    private var filteredTransactions: [Transaction] {
        if let selectedAccount = selectedAccount {
            return transactions.filter { $0.transaction_account == selectedAccount }
        } else {
            return transactions
        }
    }
    
    func addTransaction() {
        let transaction = Transaction()
        transaction.transaction_account = selectedAccount
        modelContext.insert(transaction)
        path = [transaction]
    }
    
    func deleteTransaction(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            modelContext.delete(transaction)
        }
    }
}
