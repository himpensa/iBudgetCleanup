//
//  ListCategoryView.swift
//  iBudget
//
//  Created by Antoine Himpens on 02/12/2023.
//

import SwiftUI
import SwiftData

struct ListCategoriesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @State private var path = [Category]()


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(categories) { category in
                    NavigationLink(value: category) {
                        VStack(alignment: .leading) {
                            Text(category.name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteCategory)

            }
            .navigationTitle("Categories")
            .navigationDestination(for: Category.self, destination: EditCategoryView.init)

            .toolbar {
                Button("Add Category", systemImage: "plus", action: addCategory)
            }
        }
    }
    

    
    func addCategory() {
        let category = Category()
        modelContext.insert(category)
        path = [category]
    }
    
    func deleteCategory(_ indexSet: IndexSet) {
        for index in indexSet {
            let category = categories[index]
            modelContext.delete(category)
        }
    }
}



#Preview {
    ListCategoriesView()
}
