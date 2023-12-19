//
//  EditAccountView.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/12/2023.
//

import SwiftUI
import SwiftData

struct EditAccountView: View {
    @Bindable var account: Account
    
    var body: some View {
        Form {
            TextField("Name", text: $account.account_name)
            }
        
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Account.self, configurations: config)

        let example = Account()
        return EditAccountView(account: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
