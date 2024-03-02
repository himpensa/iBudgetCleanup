//
//  ListCurrenciesView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct ListCurrenciesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Currency.currency_name)  var currencies: [Currency]
    @State private var path = [Currency]()
    @State private var showingSheet = false


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(currencies) { currency in
                    NavigationLink(value: currency) {
                        VStack(alignment: .leading) {
                            Text(currency.currency_name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteCurrency)

            }
            .navigationTitle("Currencies")
            .navigationDestination(for: Currency.self, destination: EditCurrencyView.init)

            .toolbar {
                Button("Add Currency", systemImage: "plus") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    NewCurrencyView(showingSheet: $showingSheet)
                }
            }
        }
    }
        
    func deleteCurrency(_ indexSet: IndexSet) {
        for index in indexSet {
            let currency = currencies[index]
            modelContext.delete(currency)
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
