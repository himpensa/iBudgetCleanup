//
//  ListPayeesView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct ListPayeesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var payees: [Payee]
    @State private var path = [Payee]()


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(payees) { payee in
                    NavigationLink(value: payee) {
                        VStack(alignment: .leading) {
                            Text(payee.payee_name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deletePayee)

            }
            .navigationTitle("Payee")
            .navigationDestination(for: Payee.self, destination: EditPayeeView.init)

            .toolbar {
                Button("Add Payee", systemImage: "plus", action: addPayee)
            }
        }
    }
    

    
    func addPayee() {
        let payee = Payee()
        modelContext.insert(payee)
        path = [payee]
    }
    
    func deletePayee(_ indexSet: IndexSet) {
        for index in indexSet {
            let payee = payees[index]
            modelContext.delete(payee)
        }
    }
}



#Preview {
    ListPayeesView()
}
