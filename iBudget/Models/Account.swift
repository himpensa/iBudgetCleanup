//
//  Account.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Account {
    var account_id: Int
    var account_name: String
    var account_description: String?
    var currency_id: Int
    var account_type:String
    var starting_balance: Double
    var is_opened: Bool
    var transactions: [Transaction] = []  // Liste de transactions
    

    init()
    {
        self.account_id = 0
        self.account_name = ""
        self.account_description = nil
        self.currency_id = 0
        self.account_type = "Cash"
        self.starting_balance = 0
        self.is_opened = true
    }
    
    init(account_id: Int, account_name: String, account_description: String, currency_id: Int, account_type: String, starting_balance: Double, is_opened: Bool, transactions: [Transaction] = []) {
        self.account_id = account_id
        self.account_name = account_name
        self.account_description = account_description
        self.currency_id = currency_id
        self.account_type = account_type
        self.starting_balance = starting_balance
        self.is_opened = is_opened
        self.transactions = transactions
    }

  func describe() -> String {
      return "Account [ID: \(account_id), Name: \(account_name), Description: \( account_description), Currency: \(currency_id), Type: \(account_type), Starting balance: \(starting_balance), is Opened: \(is_opened)]"
  }

  func update(account_name: String, account_description: String, currency_id: Int, account_type: String, starting_balance: Double,is_opened: Bool, transactions: [Transaction]) {
      self.account_name = account_name
      self.account_description = account_description
      self.currency_id = currency_id
      self.account_type = account_type
      self.starting_balance = starting_balance
      self.is_opened = is_opened
      self.transactions = transactions
  }
}
