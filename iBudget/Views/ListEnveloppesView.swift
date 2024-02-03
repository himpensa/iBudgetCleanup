//
//  ListEnveloppesView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/02/2024.
//

import SwiftUI
import SwiftData

struct ListEnveloppesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var enveloppes: [Enveloppe]
    @State private var path = [Enveloppe]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(enveloppes) { enveloppe in
                    NavigationLink(destination:
                        EditEnveloppeView(enveloppe: enveloppe)
                    ) {
                        VStack(alignment: .leading) {
                            Text(enveloppe.enveloppe_name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteEnveloppe)
            }
            .navigationTitle("Enveloppes")

            .toolbar {
                Button("Add Enveloppe", systemImage: "plus", action: addEnveloppe)
            }
        }
    }

    func addEnveloppe() {
        let enveloppe = Enveloppe()
        modelContext.insert(enveloppe)
        path = [enveloppe]
    }

    func deleteEnveloppe(_ indexSet: IndexSet) {
        for index in indexSet {
            let enveloppe = enveloppes[index]
            modelContext.delete(enveloppe)
        }
    }
}

#Preview {
    ListEnveloppesView()
}
