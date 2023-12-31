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
            TextField("Name", text: $currency.currency_name)
            TextField("Short Name", text: $currency.currency_alphabetic_code)
            TextField("Symbol", text: $currency.currency_symbol)
            TextField("Numeric Code", text: $currency.currency_numeric_code)
            TextField("Minor Unit", value: $currency.currency_minor_unit, formatter: NumberFormatter())
            }
        
        .navigationTitle("Edit Currency")
        .navigationBarTitleDisplayMode(.inline)    }
}
