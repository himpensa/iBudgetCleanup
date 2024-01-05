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
    @State private var isDefault: Bool = false
    @State private var showTooltip: Bool = false
    @Query(sort: \Currency.currency_name)  var availableCurrencies: [Currency]
    
    init(currency: Currency) {
        self._currency = Bindable(currency)
    }
    
    var isDefaultCurrencySet: Bool {
        availableCurrencies.contains(where: { $0.currency_is_default && $0.id != currency.id })
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $currency.currency_name)
            TextField("Short Name", text: $currency.currency_alphabetic_code)
            TextField("Symbol", text: $currency.currency_symbol)
            TextField("Numeric Code", text: $currency.currency_numeric_code)
            TextField("Minor Unit", value: $currency.currency_minor_unit, formatter: NumberFormatter())
            

            Section(header: Text("Is Default")) {
                           Toggle("Is Default", isOn: $currency.currency_is_default)
                    .onChange(of: currency.currency_is_default) { newValue in
                                           if newValue {
                                               setDefaultCurrency()
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
