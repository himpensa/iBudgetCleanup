//
//  EditEnveloppeView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/02/2024.
//

import SwiftUI
import SwiftData

struct EditEnveloppeView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var enveloppe: Enveloppe


    
    init(enveloppe : Enveloppe) {
        self._enveloppe = Bindable(enveloppe)
        }
    
    var body: some View {
        Form {
            Section(header: Text("Enveloppe Title")) {
                TextField("Name", text: $enveloppe.enveloppe_name)
            }
   

        }
        .navigationTitle("Edit Budget")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditEnveloppeView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Enveloppe.self,Category.self, configurations: config)
    //    let sampleCategory = Category(category_name: "Restaurant", category_icon: "questionmark.circle", parentID: nil)

        let sampleEnveloppe = Enveloppe()

        return EditEnveloppeView(enveloppe: sampleEnveloppe)
            .modelContainer(container)
    }
}
