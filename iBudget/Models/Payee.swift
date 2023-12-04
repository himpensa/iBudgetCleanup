//
//  Payee.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import Foundation

class Payee {
  var payee_id: Int
  var payee_name: String

  init(payee_id: Int, payee_name: String) {
    self.payee_id = payee_id
    self.payee_name = payee_name
  }

  func description() -> String {
    return "Payee [ID: \(payee_id), Name: \(payee_name)]"
  }

  func update(payee_name: String) {
    self.payee_name = payee_name
  }
}
