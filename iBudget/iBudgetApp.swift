//
//  iBudgetApp.swift
//  iBudget
//
//  Created by Antoine Himpens on 11/11/2023.
//

import SwiftUI
import SwiftData



@main
struct iBudgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Account.self, Category.self, Transaction.self, Currency.self, Payee.self, Tag.self, Budget.self])
    }
}
