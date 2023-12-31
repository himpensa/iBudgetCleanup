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
    @Query var categories: [Category]  // Récupérer la liste des categories
    @Bindable var payee: Payee
    @State private var selectedCategory: Category?
    
    init(payee: Payee) {
        self._payee = Bindable(payee)
        self._selectedCategory = State(initialValue: payee.payee_default_category)
        }
    
    var body: some View {
        Form {
            TextField("Name", text: $payee.payee_name)
            Section(header: Text("Category")) {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.category_name).tag(category as Category?)
                    }
                }
            }
            .onChange(of: selectedCategory) { newCategory in
                payee.payee_default_category = newCategory
            }
            }
        
        .navigationTitle("Edit Payee")
        .navigationBarTitleDisplayMode(.inline)    }
}

