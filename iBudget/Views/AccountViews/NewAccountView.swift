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
                                if newValue {
                                    setDefaultAccount()
                                }
                           }
                    }
                }
                    .navigationBarTitle(Text("New Account"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        print("test")
                        addAccount()
                        dismiss()
                                    }) {
                                        Text("Save").bold()
                                    })
                }
            }

            func addAccount() {
                print(account_name)
               
                let account = Account(account_id: account_id, account_name: account_name, account_description: "account_description", account_currency: account_currency, account_type: "Cash", starting_balance: 0, is_opened: true, account_is_default: account_is_default, transactions: [])
                
                modelContext.insert(account)
            }

        func setDefaultAccount() {
    /*        for index in availableCurrencies.indices {
                if availableCurrencies[index].id == currency_id {
                    availableCurrencies[index].currency_is_default = true
                } else {
                    availableCurrencies[index].currency_is_default = false
                }
            }*/
            print("todo")
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
