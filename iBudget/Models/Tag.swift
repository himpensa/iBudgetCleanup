//
//  Tag.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import Foundation

class Tag {
  var tag_id: Int
  var tag_name: String

  init(tag_id: Int, tag_name: String) {
    self.tag_id = tag_id
    self.tag_name = tag_name
  }

  func description() -> String {
    return "Tag [ID: \(tag_id), Name: \(tag_name)]"
      }

  func update(tag_name: String) {
    self.tag_name = tag_name
    }
  }
