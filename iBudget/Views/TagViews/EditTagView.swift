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
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Binding var showingSheet: Bool
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    TextField("Name", text: $tag.tag_name)
                }
            }
            .navigationTitle("Edit Tag")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    showingConfirmationAlert = true
                }) {
                    Text("Cancel").foregroundColor(.red)
                }
                .alert(isPresented: $showingConfirmationAlert) {
                    Alert(title: Text("Are you sure?"), message: Text("Your changes will not be saved."), primaryButton: .default(Text("Yes")) {
                        dismiss()
                    }, secondaryButton: .cancel(Text("No")))
                },
                trailing: Button(action: {
                    print("Saved")
                    dismiss()
                }) {
                    Text("Save").bold()
                }
            )
        }
    }
    }
