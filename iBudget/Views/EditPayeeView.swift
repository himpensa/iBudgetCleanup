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
    @Bindable var payee: Payee
    
    var body: some View {
        Form {
            TextField("Name", text: $payee.payee_name)
            }
        
        .navigationTitle("Edit Payee")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Payee.self, configurations: config)

        let example = Payee(payee_name: "Example Destination")
        return EditPayeeView(payee: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
