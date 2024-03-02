//
//  SimpleListTransactionsFromList.swift
//  iBudget
//
//  Created by Antoine Himpens on 08/02/2024.
//

import SwiftUI

struct SimpleListTransactionsFromList: View {
    var transactions : [Transaction] = []
    
    @State private var lastDate = DateFormatter().date(from: "2020/01/01") ?? Date()
        
        private var groupedTransactions: [Date: [Transaction]] {
            var groupedDict = Dictionary(grouping: transactions, by: { Calendar.current.startOfDay(for: $0.transaction_date) })
            groupedDict = groupedDict.mapValues { $0.sorted(by: { $0.transaction_date > $1.transaction_date }) }
            return groupedDict
        }
        
    init(transactions : [Transaction]) {
        self.transactions = transactions
    }
    
        var body: some View {
            NavigationView {
                List {
                    ForEach(groupedTransactions.sorted(by: { $0.key > $1.key }), id: \.key) { date, transactionsForDate in
                        Section(header: Text(dateFormatted(date))) {
                            ForEach(transactionsForDate, id: \.self) { transaction in
                                NavigationLink(destination: EditTransactionView(transaction: transaction)) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Image(systemName: transaction.transaction_category?.category_icon ?? "questionmark.circle")
                                            Text(transaction.transaction_details)
                                            Spacer()
                                            Text(String(format: "%.2f", transaction.transaction_amount))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                
            }
        }
        
        
        private func header(for index: Int) -> Text {
            let transaction = transactions[index]
            print(dateFormatted(transaction.transaction_date))
            return Text(dateFormatted(transaction.transaction_date))
        }
        
        private func dateFormatted(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
        
    }
