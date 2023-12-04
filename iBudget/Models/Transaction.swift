//
//  Transaction.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import Foundation


// Classe de base Transaction
class Transaction: Identifiable {
    var transaction_id: Int
    var transaction_details: String
    var transaction_date: Date
    var transaction_amount: Double
    var account_id: Int
    var category_id: Int
    var currency_id: Int
    var payee_id: Int

    // ... les autres propriétés et méthodes de Transaction ...

    init(transaction_id: Int, transaction_details: String, transaction_date: Date, transaction_amount: Double, account_id: Int, category_id: Int, currency_id: Int, payee_id: Int) {
        self.transaction_id = transaction_id
        self.transaction_details = transaction_details
        self.transaction_date = transaction_date
        self.transaction_amount = transaction_amount
        self.account_id = account_id
        self.category_id = category_id
        self.currency_id = currency_id
        self.payee_id = payee_id
    }
    
    func description() -> String {
      return "Transaction [ID: \(transaction_id), Details: \(transaction_details), Amount: \(transaction_amount)]"
    }

    func update(transaction_details: String, transaction_date: Date, transaction_amount: Double) {
      self.transaction_details = transaction_details
      self.transaction_date = transaction_date
      self.transaction_amount = transaction_amount
    }
}

// Planned est une sous-classe de Transaction
class Planned: Transaction {
    var planned_id: Int
    var planned_date: Date
    var end_date: Date?
    var frequency_interval: Int
    var frequency_unit: String
    var is_expense: Bool

    // Le constructeur de Planned appelle le constructeur de la classe parente (Transaction) pour initialiser les propriétés communes
    init(planned_id: Int, transaction_details: String, transaction_date: Date, transaction_amount: Double, account_id: Int, category_id: Int, currency_id: Int, payee_id: Int, planned_date: Date, end_date: Date?, frequency_interval: Int, frequency_unit: String, is_expense: Bool) {
        
        self.planned_id = planned_id
        self.planned_date = planned_date
        self.end_date = end_date
        self.frequency_interval = frequency_interval
        self.frequency_unit = frequency_unit
        self.is_expense = is_expense
        
        super.init(transaction_id: planned_id, transaction_details: transaction_details, transaction_date: transaction_date, transaction_amount: transaction_amount, account_id: account_id, category_id: category_id, currency_id: currency_id, payee_id: payee_id)
    }
    
    override func description() -> String {
      return "Planned [ID: \(planned_id), Planned Date: \(planned_date), End Date: \(String(describing: end_date)), Frequency: \(frequency_interval) \(frequency_unit), Is Expense: \(is_expense)]"
    }

    func update(planned_date: Date, end_date: Date?, frequency_interval: Int, frequency_unit: String, is_expense: Bool, category_id: Int, currency_id: Int, payee_id: Int, account_id: Int) {
      self.planned_date = planned_date
      self.end_date = end_date
      self.frequency_interval = frequency_interval
      self.frequency_unit = frequency_unit
      self.is_expense = is_expense
      self.category_id = category_id
      self.currency_id = currency_id
      self.payee_id = payee_id
      self.account_id = account_id
    }
    
    // ... d'autres méthodes pour Planned ...
}
