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
                        HStack {
                            // Icône agrandie
                            Image(systemName: category.category_icon)
                                .resizable() // Rend l'image redimensionnable
                                .scaledToFit() // Garde le ratio d'aspect
                                .frame(width: 40, height: 40) // Définit la taille de l'icône
                                .foregroundColor(.accentColor) // Vous pouvez personnaliser la couleur si nécessaire
                            
                            VStack(alignment: .leading) {
                                Text(category.category_name)
                                    .font(.headline)
                            }
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
