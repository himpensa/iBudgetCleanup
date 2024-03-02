//
//  NewAccountView.swift
//  iBudget
//
//  Created by Antoine Himpens on 09/02/2024.
//

import SwiftUI
import SwiftData

struct NewAccountView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Binding var showingSheet: Bool
    @Query(sort: \Account.account_name)  var availableAccounts: [Account]
    @Query(sort: [SortDescriptor(\Currency.currency_name)]) var currencies: [Currency]
    @State private var showingConfirmationAlert = false


    @State private var isDefault: Bool = false
    
    @State private var selectedCurrency: Currency?=nil
    
    @State private var account_name = String()
    @State private var account_currency: Currency?
    @State private var account_is_default: Bool = false
    @State private var account_id: UUID = UUID()
        
    var body: some View {
            NavigationStack {
                Form {
                    HStack  {
                        TextField("Name", text: $account_name)
                    }
                    
                    Section(header: Text("Currency")) {
                        currencyPicker
                    }
                    .onChange(of: selectedCurrency) { newValue, _ in
                        account_currency = newValue
                    }
                    HStack  {
                        Toggle("Default Account", isOn: $account_is_default)
                            .onChange(of: account_is_default) { newValue, _ in
                           }
                    }
                }
                    .navigationBarTitle(Text("New Account"), displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        showingConfirmationAlert = true
                    }) {
                        Text("Cancel").foregroundColor(.red)
                            .alert(isPresented: $showingConfirmationAlert) {
                                Alert(title: Text("Are you sure?"), message: Text("Your changes will not be saved."), primaryButton: .default(Text("Yes")) {
                                    dismiss()
                                }, secondaryButton: .cancel(Text("No")))
                            }
                    }, trailing: Button(action: {
                        print("Saved")
                        addAccount()
                        dismiss()
                    }) {
                        Text("Save").bold()
                    })
                }
            }

    func addAccount() {
        guard let selectedCurrency = selectedCurrency else {
            // Handle the case when no currency is selected
            return
        }
        print(selectedCurrency.currency_name)

        let account = Account(account_id: account_id, account_name: account_name, account_description: "account_description", account_currency: nil, account_type: "Cash", starting_balance: 0, is_opened: true, account_is_default: account_is_default, transactions: [])
        
        modelContext.insert(account)
        account.account_currency=selectedCurrency
        if account_is_default {
            for index in availableAccounts.indices {
                if availableAccounts[index].account_id == account.account_id {
                } else {
                    availableAccounts[index].account_is_default = false
                }
            }
        }
    }


    private var currencyPicker: some View {
        Picker(selection: $selectedCurrency, label: Text("Currency")) {
            if currencies.isEmpty {
                // If currencies array is empty, show a default value
                Text("Sélectionnez").tag(nil as Currency?)
            } else {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency.currency_name).tag(currency as Currency?)
                }
            }
        }
        .onAppear {
            if currencies.isEmpty {
                // If currencies array is empty, set the default value to nil
                selectedCurrency = nil
            } else {
                selectedCurrency = currencies.first { $0.currency_is_default }
            }
        }
    }
}
