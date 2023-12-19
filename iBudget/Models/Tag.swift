//
//  Tag.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Tag {
  var tag_name: String

  init(tag_name: String = "") {
    self.tag_name = tag_name
  }

  func description() -> String {
    return "Name: \(tag_name)]"
      }

  func update(tag_name: String) {
    self.tag_name = tag_name
    }
  }
