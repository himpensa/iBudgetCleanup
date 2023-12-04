//
//  Budget.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import Foundation

class Budget {
  var budget_id: Int
  var budget_name: String
  var budget_date: Date
  var budget_limit: Double

    init()
    {
        self.budget_id = 0
        self.budget_name = ""
        self.budget_date = Date()
        self.budget_limit = 0
    }
    
  init(budget_id: Int, budget_name: String, budget_date: Date, budget_limit: Double) {
    self.budget_id = budget_id
    self.budget_name = budget_name
    self.budget_date = budget_date
    self.budget_limit = budget_limit
  }

  func description() -> String {
    return "Budget [ID: \(budget_id), Name: \(budget_name), Date: \(budget_date), Limit: \(budget_limit)]"
  }

  func update(budget_name: String, budget_date: Date, budget_limit: Double) {
    self.budget_name = budget_name
    self.budget_date = budget_date
    self.budget_limit = budget_limit
  }
}
