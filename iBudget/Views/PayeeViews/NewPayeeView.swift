//
//  NewPayeeView.swift
//  iBudget
//
//  Created by Antoine Himpens on 16/02/2024.
//

import SwiftUI
import SwiftData

struct NewPayeeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Binding var showingSheet: Bool    
    @State private var showingConfirmationAlert = false

    
    @State private var payeeName = String()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Payee Name")) {
                    TextField("Name", text: $payeeName)
                }
            }
            .navigationBarTitle(Text("New Payee"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                showingConfirmationAlert = true
            }) {
                Text("Cancel").foregroundColor(.red)
                    .alert(isPresented: $showingConfirmationAlert) {
                        Alert(title: Text("Are you sure?"), message: Text("Your changes will not be saved."), primaryButton: .default(Text("Yes")) {
                            dismiss()
                        }, secondaryButton: .cancel(Text("No")))
                    }
            }, trailing: Button(action: {
                print("Saved")
                addPayee()
                dismiss()
            }) {
                Text("Save").bold()
            })
        }
    }
    
    func addPayee() {
        let payee = Payee(payee_name: payeeName)
        modelContext.insert(payee)
    }
    
    
}
