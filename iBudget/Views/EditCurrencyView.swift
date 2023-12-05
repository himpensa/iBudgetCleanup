//
//  EditCurrencyView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct EditCurrencyView: View {
    @Bindable var currency: Currency
    
    var body: some View {
        Form {
            TextField("Name", text: $currency.name)
            TextField("Short Name", text: $currency.short_name)
            TextField("Symbol", text: $currency.currency_symbol)
            }
        
        .navigationTitle("Edit Currency")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Currency.self, configurations: config)

        let example = Currency(name: "Example Currency")
        return EditCurrencyView(currency: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
