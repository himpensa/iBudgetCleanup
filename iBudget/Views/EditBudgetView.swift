//
//  EditBudgetView.swift
//  iBudget
//
//  Created by Antoine Himpens on 03/12/2023.
//


import Foundation
import SwiftUI
import SwiftData

struct EditBudgetView: View {
    @Bindable var budget: Budget
    
    var body: some View {
        Form {
            TextField("Name", text: $budget.budget_name)
            }
        
        .navigationTitle("Edit Budget")
        .navigationBarTitleDisplayMode(.inline)    }
}
