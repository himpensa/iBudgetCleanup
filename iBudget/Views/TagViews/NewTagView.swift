//
//  NewTagView.swift
//  iBudget
//
//  Created by Antoine Himpens on 11/02/2024.
//
    import SwiftUI
    import SwiftData

    struct NewTagView: View {
        @Environment(\.dismiss) var dismiss
        @Environment(\.modelContext) var modelContext
        @Binding var showingSheet: Bool
        @State private var showingConfirmationAlert = false

       
        @State private var tag_name = String()
        @State private var tag_id: UUID = UUID()
        
        var body: some View {
                NavigationStack {
                    Form {
                        Section() {
                            TextField("Name", text: $tag_name)
                        }
                    }
                    .navigationBarTitle(Text("New Tag"), displayMode: .inline)
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
                        addTag()
                        dismiss()
                    }) {
                        Text("Save").bold()
                    })
                }
            }
            func addTag() {               
                let tag = Tag(tag_name: tag_name)
                modelContext.insert(tag)
            }
    }
