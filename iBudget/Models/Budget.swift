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
    var budget_start_date: Date
    var budget_end_date: Date
    var budget_limit: Double
    var budget_number: Int
    var budget_interval: Interval
    var categories:  [Category] = []
    
    init(budget_id: UUID = UUID(), budget_name: String = "", budget_start_date: Date = Date(), budget_end_date: Date = Date(), budget_limit: Double=0, budget_number: Int=1, budget_interval: Interval = .month, categories: [Category] = []) {
    self.budget_id = budget_id
    self.budget_name = budget_name
    self.budget_start_date = budget_start_date
    self.budget_end_date = budget_end_date
    self.budget_limit = budget_limit
    self.budget_number = budget_number
    self.budget_interval = budget_interval
    self.categories = categories
  }

  func description() -> String {
    return "Budget [Name: \(budget_name), Date: \(budget_end_date), Limit: \(budget_limit)]"
  }

  func update(budget_name: String, budget_start_date: Date, budget_end_date: Date, budget_limit: Double, categories: [Category]) {
    self.budget_name = budget_name
    self.budget_end_date = budget_end_date
    self.budget_limit = budget_limit
      self.categories = categories
  }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        budget_id = try values.decode(UUID.self, forKey: .budget_id)
        budget_name = try values.decode(String.self, forKey: .budget_name)
        budget_start_date=try values.decode(Date.self, forKey: .budget_start_date)
        budget_end_date=try values.decode(Date.self, forKey: .budget_end_date)
        budget_limit=try values.decode(Double.self, forKey: .budget_limit)
        budget_number=try values.decode(Int.self, forKey: .budget_number)
        budget_interval=try values.decode(Interval.self, forKey: .budget_interval)
        categories=try values.decode([Category].self, forKey: .categories)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(budget_id, forKey: .budget_id)
        try container.encode(budget_name, forKey: .budget_name)
        try container.encode(budget_limit, forKey: .budget_limit)
        try container.encode(budget_start_date, forKey: .budget_start_date)
        try container.encode(budget_end_date, forKey: .budget_end_date)
        try container.encode(budget_number, forKey: .budget_number)
        try container.encode(budget_interval, forKey: .budget_interval)
        try container.encode(categories, forKey: .categories)
    }

    enum CodingKeys: String, CodingKey {
        case budget_id
        case budget_name
        case budget_limit
        case budget_start_date
        case budget_end_date
        case budget_number
        case budget_interval
        case categories
    }
}
