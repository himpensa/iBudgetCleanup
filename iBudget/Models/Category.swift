//
//  Category.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import Foundation

class Category {
  var category_id: Int
  var category_name: String
  var category_description: String?
  var is_expense: Bool
  var parent_category_id: Int?

  init(category_id: Int, category_name: String, category_description: String?, is_expense: Bool, parent_category_id: Int?) {
    self.category_id = category_id
    self.category_name = category_name
    self.category_description = category_description
    self.is_expense = is_expense
    self.parent_category_id = parent_category_id
  }

  func description() -> String {
    return "Category [ID: \(category_id), Name: \(category_name), Is Expense: \(is_expense)]"
  }

  func update(category_name: String, category_description: String?, is_expense: Bool) {
  self.category_name = category_name
  self.category_description = category_description
  self.is_expense = is_expense
  }
}


