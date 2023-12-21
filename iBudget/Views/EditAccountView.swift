//
//  EditAccountView.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/12/2023.
//

import SwiftUI
import SwiftData

struct EditAccountView: View {
    @Bindable var account: Account
    @Query(sort: [SortDescriptor(\Currency.currency_name)]) var currencies: [Currency]
    
    @State private var selectedCurrency: Currency?
    
    init(account: Account) {
        self._account = Bindable(account)
        self._selectedCurrency = State(initialValue: account.account_currency)
        }
    
    var body: some View {
        Form {
            TextField("Name", text: $account.account_name)
            
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
            }
        
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Account.self, configurations: config)

        let example = Account()
        return EditAccountView(account: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
