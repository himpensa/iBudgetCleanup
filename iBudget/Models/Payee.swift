//
//  Payee.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Payee {
  var payee_name: String

  init(payee_name: String = "") {
    self.payee_name = payee_name
  }

  func description() -> String {
    return "Name: \(payee_name)]"
  }

  func update(payee_name: String) {
    self.payee_name = payee_name
  }
}
