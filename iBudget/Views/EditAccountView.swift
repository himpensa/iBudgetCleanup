//
//  EditAccountView.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/12/2023.
//

import SwiftUI
import SwiftData

struct EditAccountView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var account: Account
    @Query(sort: [SortDescriptor(\Currency.currency_name)]) var currencies: [Currency]
    @Query(sort: \Account.account_name)  var availableAccounts: [Account]
    
    init(account: Account) {
        self._account = Bindable(account)
        }
    
    var isDefaultAccountSet: Bool {
        availableAccounts.contains(where: { $0.account_is_default && $0.id != account.id })
    }
    
    var body: some View {
        Form {
            HStack  {
                TextField("Name", text: $account.account_name)
            }
            
            Section(header: Text("Currency")) {
                currencyPicker
            }
            .onChange(of: account.account_currency) { newValue, _ in
                account.account_currency = newValue
            }
            HStack  {
                Toggle("Default Account", isOn: $account.account_is_default)
                    .onChange(of: account.account_is_default) { newValue, _ in
                            setDefaultAccount()
                   }
            }
        }
        
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func setDefaultAccount() {
            for index in availableAccounts.indices {
                if account.account_is_default {
                    if availableAccounts[index].account_id == account.account_id {
                    } else {
                        availableAccounts[index].account_is_default = false
                    }
            }
        }
    }
    
    private var currencyPicker: some View {
        Picker(selection: $account.account_currency, label: Text("Currency")) {
            if currencies.isEmpty {
                // If currencies array is empty, show a default value
                Text("Sélectionnez").tag(nil as Currency?)
            } else {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency.currency_name).tag(currency as Currency?)
                }
            }
        }
    }

}
