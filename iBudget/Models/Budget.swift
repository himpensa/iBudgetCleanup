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
    var budget_date: Date
    var budget_limit: Double
    
    init(budget_id: UUID = UUID(), budget_name: String = "", budget_date: Date = Date(), budget_limit: Double=0) {
    self.budget_id = budget_id
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        budget_id = try values.decode(UUID.self, forKey: .budget_id)
        budget_name = try values.decode(String.self, forKey: .budget_name)
        budget_date=Date()
        budget_limit=0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(budget_id, forKey: .budget_id)
        try container.encode(budget_name, forKey: .budget_name)
    }

    enum CodingKeys: String, CodingKey {
        case budget_id
        case budget_name
    }
    
    
}
