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
