//
//  Budget.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Budget : Codable{
    var budget_id: UUID
    var budget_name: String
    var budget_end_date: Date
    var budget_limit: Double
    var categories:  [Category] = []
    
    init(budget_id: UUID = UUID(), budget_name: String = "", budget_end_date: Date = Date(), budget_limit: Double=0, categories: [Category] = []) {
    self.budget_id = budget_id
    self.budget_name = budget_name
    self.budget_end_date = budget_end_date
    self.budget_limit = budget_limit
    self.categories = categories
  }

  func description() -> String {
    return "Budget [Name: \(budget_name), Date: \(budget_end_date), Limit: \(budget_limit)]"
  }

  func update(budget_name: String, budget_end_date: Date, budget_limit: Double, categories: [Category]) {
    self.budget_name = budget_name
    self.budget_end_date = budget_end_date
    self.budget_limit = budget_limit
      self.categories = categories
  }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        budget_id = try values.decode(UUID.self, forKey: .budget_id)
        budget_name = try values.decode(String.self, forKey: .budget_name)
        budget_end_date=try values.decode(Date.self, forKey: .budget_end_date)
        budget_limit=try values.decode(Double.self, forKey: .budget_limit)
        categories=try values.decode([Category].self, forKey: .categories)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(budget_id, forKey: .budget_id)
        try container.encode(budget_name, forKey: .budget_name)
        try container.encode(budget_limit, forKey: .budget_limit)
        try container.encode(budget_end_date, forKey: .budget_end_date)
        try container.encode(categories, forKey: .categories)
    }

    enum CodingKeys: String, CodingKey {
        case budget_id
        case budget_name
        case budget_limit
        case budget_end_date
        case categories
    }
    
    
}
