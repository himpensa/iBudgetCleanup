//
//  EditCurrencyView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct EditCurrencyView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var currency: Currency
    @State private var isDefault: Bool = false
    @Query(sort: \Currency.currency_name)  var availableCurrencies: [Currency]
    
    init(currency: Currency) {
        self._currency = Bindable(currency)
    }
    
    var isDefaultCurrencySet: Bool {
        availableCurrencies.contains(where: { $0.currency_is_default && $0.id != currency.id })
    }
    
    var body: some View {
        Form {
            Section(header: Text("Currency Name")) {
                TextField("Name", text: $currency.currency_name)
            }
            Section(header: Text("Codes & Symbols")) {
                HStack  {
                    Text("Alphabetic Code")
                    Spacer()
                    TextField("Short Name", text: $currency.currency_alphabetic_code)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack  {
                    Text("Numeric Code")
                    Spacer()
                    TextField("Numeric Code", text: $currency.currency_numeric_code)                    .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack  {
                    Text("Symbol")
                    Spacer()
                    TextField("Symbol", text: $currency.currency_symbol)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
            }
            Section(header: Text("Parameters")) {
                HStack  {
                    Text("Minor Unit")
                    Spacer()
                    TextField("Minor Unit", value: $currency.currency_minor_unit, formatter: NumberFormatter())
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack  {
                    Toggle("Default Currency", isOn: $currency.currency_is_default)
                        .onChange(of: currency.currency_is_default) { newValue, _ in
                            if newValue {
                                setDefaultCurrency()
                            }
                        }
                }
            }
        }
        .navigationTitle("Edit Currency")
        .navigationBarTitleDisplayMode(.inline)    }
    
    func setDefaultCurrency() {
            for index in availableCurrencies.indices {
                if availableCurrencies[index].id == currency.id {
                    availableCurrencies[index].currency_is_default = true
                } else {
                    availableCurrencies[index].currency_is_default = false
                }
            }
        }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try! ModelContainer(for: Currency.self, configurations: config)

    let sampleCurrency = Currency(currency_name: "US Dollar", currency_symbol: "$", currency_alphabetic_code: "USD", currency_numeric_code: "840", currency_minor_unit: 2, currency_is_default: false)

    return EditCurrencyView(currency: sampleCurrency)
        .modelContainer(container)
}
