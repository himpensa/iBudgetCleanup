import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Bindable var category: Category
    let icons = [
        "cup.and.saucer.fill", "scissors.circle", "sportscourt.circle",
        "pawprint.circle", "car.circle", "scissors.circle",
        "printer.fill.and.paper.fill", "person.circle", "cart.circle",
        "pencil.circle", "camera.circle", "person.2.circle",
        "book.circle", "film.circle", "leaf.circle",
        "cross.case.circle", "pills.circle", "bus.circle",
        "person.crop.circle", "cart.circle", "camera.circle"
    ] // Liste des icônes SF Symbols disponibles
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        Form {
            TextField("Name", text: $category.category_name)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .foregroundColor(category.category_icon == icon ? .blue : .gray) // Changez les couleurs selon vos préférences
                        .onTapGesture {
                            category.category_icon = icon
                        }
                }
            }
        }
        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}
