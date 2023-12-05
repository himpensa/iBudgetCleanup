//
//  EditDestinationView.swift
//  iBudget
//
//  Created by Antoine Himpens on 11/11/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Bindable var category: Category
    
    var body: some View {
        Form {
            TextField("Name", text: $category.name)
            }
        
        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, configurations: config)

        let example = Category(name: "Example Destination")
        return EditCategoryView(category: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
