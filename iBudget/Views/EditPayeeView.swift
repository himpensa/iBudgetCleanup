//
//  EditPayeeView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct EditPayeeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]  // Récupérer la liste des categories
    @Bindable var payee: Payee
    @State private var selectedCategory: Category?
    
    init(payee: Payee) {
        self._payee = Bindable(payee)
        self._selectedCategory = State(initialValue: payee.payee_default_category)
        }
    
    var body: some View {
        Form {
            Section(header: Text("Payee Name")) {
                TextField("Name", text: $payee.payee_name)
            }
            Section(header: Text("Category")) {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.category_name).tag(category as Category?)
                    }
                }
            }
            .onChange(of: selectedCategory) { newCategory, _ in
                payee.payee_default_category = newCategory
            }
            }
        
        .navigationTitle("Edit Payee")
        .navigationBarTitleDisplayMode(.inline)    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try! ModelContainer(for: Payee.self, configurations: config)

    let samplePayee = Payee(payee_name: "Carrefour")


    return EditPayeeView(payee: samplePayee)
        .modelContainer(container)
}
