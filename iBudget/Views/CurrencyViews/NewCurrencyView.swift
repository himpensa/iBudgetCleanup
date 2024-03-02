//
//  NewCurrencyView.swift
//  iBudget
//
//  Created by Antoine Himpens on 09/02/2024.
//

import SwiftUI
import SwiftData

struct NewCurrencyView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var showingConfirmationAlert = false
    @Binding var showingSheet: Bool
    @Query(sort: \Currency.currency_name)  var availableCurrencies: [Currency]
    
    @State private var isDefault: Bool = false
    
    @State private var currency_name = String()
    @State private var currency_alphabetic_code = String()
    @State private var currency_numeric_code = String()
    @State private var currency_symbol = String()
    @State private var currency_minor_unit: Int = 2
    @State private var currency_is_default: Bool = false
    @State private var currency_id: UUID = UUID()
    
    var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("Currency Name")) {
                        TextField("Name", text: $currency_name)
                    }
                    Section(header: Text("Codes & Symbols")) {
                        HStack  {
                            Text("Alphabetic Code")
                            Spacer()
                            TextField("Short Name", text: $currency_alphabetic_code)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack  {
                            Text("Numeric Code")
                            Spacer()
                            TextField("Numeric Code", text: $currency_numeric_code)                    .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack  {
                            Text("Symbol")
                            Spacer()
                            TextField("Symbol", text: $currency_symbol)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    Section(header: Text("Parameters")) {
                        HStack  {
                            Text("Minor Unit")
                            Spacer()
                            TextField("Minor Unit", value: $currency_minor_unit, formatter: NumberFormatter())
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack  {
                            Toggle("Default Currency", isOn: $currency_is_default)
                                .onChange(of: currency_is_default) { newValue, _ in
                                }
                        }
                    }
                }
                .navigationBarTitle(Text("New Currency"), displayMode: .inline)
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
                    addCurrency()
                    dismiss()
                }) {
                    Text("Save").bold()
                })
            }
        }

    func addCurrency() {
        print(currency_name)
            
        let currency = Currency(currency_name: currency_name, currency_symbol: currency_symbol, currency_alphabetic_code: currency_alphabetic_code, currency_numeric_code: currency_numeric_code, currency_minor_unit: currency_minor_unit, currency_is_default: currency_is_default)
        
        modelContext.insert(currency)
        if currency_is_default {
            for index in availableCurrencies.indices {
                if availableCurrencies[index].currency_id == currency.currency_id {
                } else {
                    availableCurrencies[index].currency_is_default = false
                }
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
