//
//  ListTagsView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import SwiftUI
import SwiftData

struct ListTagsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var tags: [Tag]
    @State private var path = [Tag]()


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(tags) { tag in
                    NavigationLink(value: tag) {
                        VStack(alignment: .leading) {
                            Text(tag.tag_name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteTag)

            }
            .navigationTitle("Tags")
            .navigationDestination(for: Tag.self, destination: EditTagView.init)

            .toolbar {
                Button("Add Tag", systemImage: "plus", action: addTag)
            }
        }
    }
    

    
    func addTag() {
        let tag = Tag()
        modelContext.insert(tag)
        path = [tag]
    }
    
    func deleteTag(_ indexSet: IndexSet) {
        for index in indexSet {
            let tag = tags[index]
            modelContext.delete(tag)
        }
    }
}



#Preview {
    ListCategoriesView()
}
