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
    @Query(sort: \Transaction.transaction_date) var transactions: [Transaction]
    @State private var path = [Transaction]()
    @State private var lastDate = DateFormatter().date(from: "2020/01/01") ?? Date()
 
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink(value: transaction) {
                        VStack {
                            /*if(lastDate != transaction.transaction_date){
                                HStack {
                                    Text(formatter.string(from: transaction.transaction_date))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .onAppear {
                                            lastDate = transaction.transaction_date
                                        }
                                }
                            }*/
                            HStack {
                                Text(transaction.transaction_details)
                                    .font(.headline)
                                Spacer() // This will push the next text to the right
                                Text(String(format: "%.2f", transaction.transaction_amount))
                                    .font(.headline)
                                
                            }
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
