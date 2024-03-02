//
//  ListPlannedView.swift
//  iBudget
//
//  Created by Antoine Himpens on 18/02/2024.
//

import SwiftUI
import SwiftData

struct ListPlannedView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Planned.planned_next_date, order: .reverse) var planneds: [Planned]
    @Query var accounts: [Account]
    @State private var selectedAccount: Account? = nil
    @State private var showingSheet = false
    @State private var showingSheetEdit = false


    var body: some View {
        NavigationStack() {
            VStack {
                List {
                    ForEach(planneds, id: \.self) { planned in
                        NavigationLink(destination: EditPlannedView(planned: planned)) {
                        VStack {
                            HStack {
                   //             Image(systemName: transaction.transaction_category!.category_icon)
                                Text(planned.planned_description)
                                    .font(.headline)
                                Spacer()
                                Text(String(format: "%.2f", planned.planned_amount))
                                    .font(.headline)

                                }
                            }
                        }
                    }
                    .onDelete(perform: deletePlanned)
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    Button("Add Planned", systemImage: "plus") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        NewPlannedView(showingSheet: $showingSheet)
                //            .presentationDetents([.medium, .large])
                    }
                }
            }
        }
    }

    private var accountPicker: some View {
        Picker(selection: $selectedAccount, label: Text("Account")) {
            ForEach(accounts, id: \.self) { account in
                Text(account.account_name).tag(account as Account?)
            }
        }
        .onAppear {
                selectedAccount = accounts.first { $0.account_is_default }
        }
    }

    private func dateFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

    private func deletePlanned(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = planneds[index]
            modelContext.delete(transaction)
        }
    }
}
