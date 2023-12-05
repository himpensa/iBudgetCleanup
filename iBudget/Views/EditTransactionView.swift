//
//  EditTransactionView.swift
//  iBudget
//
//  Created by Antoine Himpens on 02/12/2023.
//

import SwiftUI
import SwiftData

struct EditTransactionView: View {
    @Bindable var transaction: Transaction
    @Query(sort: [SortDescriptor(\Currency.name)]) var currencies: [Currency]
    @Query var accounts: [Account]  // Récupérer la liste des comptes
    @State private var selectedCurrency: Currency?
    @State private var selectedAccount: Account?  // État pour le compte sélectionné
    
    init(transaction: Transaction) {
        self._transaction = Bindable(transaction)
        self._selectedCurrency = State(initialValue: transaction.transaction_currency)
        self._selectedAccount = State(initialValue: transaction.transaction_account)  // Initialiser avec le compte actuel
    }
    
    var body: some View {
        Form {
            Section(header: Text("Transaction Details")) {
                TextField("Details", text: $transaction.transaction_details)
                DatePicker("Date", selection: $transaction.transaction_date, displayedComponents: .date)
            }
            
            Section(header: Text("Amount and Currency")) {
                TextField("Amount", value: $transaction.transaction_amount, formatter: NumberFormatter())
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency.name).tag(currency as Currency?)
                    }
                }
            }
            .onChange(of: selectedCurrency) { newValue in
                transaction.transaction_currency = newValue
            }

            Section(header: Text("Account")) {
                Picker("Account", selection: $selectedAccount) {
                    ForEach(accounts, id: \.self) { account in
                        Text(account.account_name).tag(account as Account?)
                    }
                }
            }
            .onChange(of: selectedAccount) { newAccount in
                transaction.transaction_account = newAccount
            }
        }
        .navigationTitle("Edit Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

