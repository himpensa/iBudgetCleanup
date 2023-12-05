//
//  ListTransactionsView.swift
//  iBudget
//
//  Created by Antoine Himpens on 02/12/2023.
//

import SwiftUI
import SwiftData

struct ListTransactionsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var transactions: [Transaction]
    @State private var path = [Transaction]()


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink(value: transaction) {
                        VStack(alignment: .leading) {
                            Text(transaction.transaction_details)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteTransaction)

            }
            .navigationTitle("Transactions")
            .navigationDestination(for: Transaction.self) { transaction in
                EditTransactionView(transaction: transaction)
            }


            .toolbar {
                Button("Add Transaction", systemImage: "plus", action: addTransaction)
            }
        }
    }
    

    
    func addTransaction() {
        let transaction = Transaction()
        modelContext.insert(transaction)
        path = [transaction]
    }
    
    func deleteTransaction(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            modelContext.delete(transaction)
        }
    }
}



#Preview {
    ListTransactionsView()
}
