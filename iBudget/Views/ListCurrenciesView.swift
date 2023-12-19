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
    @Query var currencies: [Currency]
    @State private var path = [Currency]()


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
                Button("Add Currency", systemImage: "plus", action: addCurrency)
            }
        }
    }
    

    
    func addCurrency() {
        let currency = Currency()
        modelContext.insert(currency)
        path = [currency]
    }
    
    func deleteCurrency(_ indexSet: IndexSet) {
        for index in indexSet {
            let currency = currencies[index]
            modelContext.delete(currency)
        }
    }
}



#Preview {
    ListCurrenciesView()
}
