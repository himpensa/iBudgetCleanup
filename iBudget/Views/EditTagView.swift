//
//  EditTagView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct EditTagView: View {
    @Bindable var tag: Tag
    
    var body: some View {
        Form {
            TextField("Name", text: $tag.tag_name)
            }
        
        .navigationTitle("Edit Tag")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Tag.self, configurations: config)

        let example = Tag(tag_name: "Example Destination")
        return EditTagView(tag: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
