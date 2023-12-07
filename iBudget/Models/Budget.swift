//
//  Budget.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Budget {
  var budget_name: String
  var budget_date: Date
  var budget_limit: Double

    init()
    {
        self.budget_name = ""
        self.budget_date = Date()
        self.budget_limit = 0
    }
    
  init(budget_name: String, budget_date: Date, budget_limit: Double) {
    self.budget_name = budget_name
    self.budget_date = budget_date
    self.budget_limit = budget_limit
  }

  func description() -> String {
    return "Budget [Name: \(budget_name), Date: \(budget_date), Limit: \(budget_limit)]"
  }

  func update(budget_name: String, budget_date: Date, budget_limit: Double) {
    self.budget_name = budget_name
    self.budget_date = budget_date
    self.budget_limit = budget_limit
  }
}
