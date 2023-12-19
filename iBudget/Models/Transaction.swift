//
//  Transaction.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

// Classe de base Transaction
@Model class Transaction {
    var transaction_details: String
    var transaction_date: Date
    var transaction_amount: Double
    var transaction_currency: Currency?
    var transaction_account: Account?
    var transaction_category: Category?

    init(transaction_details: String = "", transaction_date: Date = .now, transaction_amount: Double=0, transaction_currency: Currency? = nil, transaction_account: Account? = nil, transaction_category: Category? = nil) {
        self.transaction_details = transaction_details
        self.transaction_date = transaction_date
        self.transaction_amount = transaction_amount
        self.transaction_currency = transaction_currency
        self.transaction_account = transaction_account
        self.transaction_category = transaction_category
    }
    
    func description() -> String {
      return "Transaction [Details: \(transaction_details), Amount: \(transaction_amount), Currency: \(transaction_currency), Account: \(transaction_account), Category: \(transaction_category)]"
    }

    func update(transaction_details: String, transaction_date: Date, transaction_amount: Double, transaction_currency: Currency, transaction_account: Account, transaction_category: Category) {
        self.transaction_details = transaction_details
        self.transaction_date = transaction_date
        self.transaction_amount = transaction_amount
        self.transaction_currency = transaction_currency
        self.transaction_account = transaction_account
        self.transaction_category = transaction_category
    }
}
