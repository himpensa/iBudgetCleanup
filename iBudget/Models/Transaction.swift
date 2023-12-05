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

    init(transaction_details: String = "", transaction_date: Date = .now, transaction_amount: Double=0, transaction_currency: Currency? = nil, transaction_account: Account? = nil) {
        self.transaction_details = transaction_details
        self.transaction_date = transaction_date
        self.transaction_amount = transaction_amount
        self.transaction_currency = transaction_currency
        self.transaction_account = transaction_account
    }
    
    func description() -> String {
      return "Transaction [Details: \(transaction_details), Amount: \(transaction_amount), Currency: \(transaction_currency), Account: \(transaction_account)]"
    }

    func update(transaction_details: String, transaction_date: Date, transaction_amount: Double, transaction_currency: Currency, transaction_account: Account) {
        self.transaction_details = transaction_details
        self.transaction_date = transaction_date
        self.transaction_amount = transaction_amount
        self.transaction_currency = transaction_currency
        self.transaction_account = transaction_account
    }
}
