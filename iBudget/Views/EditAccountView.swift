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
    @State private var isDefault: Bool = false
    @Query(sort: \Account.account_name)  var availableAccounts: [Account]
    @State private var selectedCurrency: Currency?
    
    init(account: Account) {
        self._account = Bindable(account)
        self._selectedCurrency = State(initialValue: account.account_currency)
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
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency.currency_name).tag(currency as Currency?)
                    }
                }
            }
            .onChange(of: selectedCurrency) { newValue in
                account.account_currency = newValue
            }
            HStack  {
                Toggle("Default Account", isOn: $account.account_is_default)
                    .onChange(of: account.account_is_default) { newValue in
                        if newValue {
                            setDefaultAccount()
                        }
                   }
            }
        }
        
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func setDefaultAccount() {
            for index in availableAccounts.indices {
                if availableAccounts[index].id == account.id {
                    availableAccounts[index].account_is_default = true
                } else {
                    availableAccounts[index].account_is_default = false
                }
            }
        }
}
