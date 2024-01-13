//
//  Tag.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Tag : Codable{
    var tag_id: UUID
    var tag_name: String

  init(tag_id: UUID = UUID(), tag_name: String = "") {
      self.tag_id = tag_id
      self.tag_name = tag_name
  }

  func description() -> String {
    return "Name: \(tag_name)]"
      }

  func update(tag_name: String) {
    self.tag_name = tag_name
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag_id = try values.decode(UUID.self, forKey: .tag_id)
        tag_name = try values.decode(String.self, forKey: .tag_name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tag_id, forKey: .tag_id)
        try container.encode(tag_name, forKey: .tag_name)
    }

    enum CodingKeys: String, CodingKey {
        case tag_id
        case tag_name
    }
    
  }
