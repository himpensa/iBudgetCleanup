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
    @State private var showingSheet = false
    @State private var showingSheetEdit = false

    var body: some View {
        NavigationStack() {
            List {
                ForEach(tags) { tag in
                    VStack(alignment: .leading) {
                        Button(tag.tag_name) {
                        showingSheetEdit.toggle()
                    }
                    .sheet(isPresented: $showingSheetEdit) {
                        EditTagView(tag: tag, showingSheet: $showingSheetEdit)
                            .presentationDetents([.medium, .large])
                    }
                    }
                }
                .onDelete(perform: deleteTag)

            }
            .navigationTitle("Tags")
            .toolbar {
                Button("Add Tag", systemImage: "plus") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    NewTagView(showingSheet: $showingSheet)
                        .presentationDetents([.medium, .large])
                }
            }
        }
    }
    
    func deleteTag(_ indexSet: IndexSet) {
        for index in indexSet {
            let tag = tags[index]
            modelContext.delete(tag)
        }
    }
}
