//
//  Currency.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Currency {
    var currency_name: String
    var currency_symbol: String
    var currency_alphabetic_code: String
    var currency_entity: String
    var currency_numeric_code: String
    var currency_minor_unit: String

    init(currency_name: String = "", currency_symbol: String = "", currency_alphabetic_code: String = "", currency_entity: String = "", currency_numeric_code: String = "", currency_minor_unit: String = "") {
        self.currency_name = currency_name
        self.currency_symbol = currency_symbol
        self.currency_alphabetic_code = currency_alphabetic_code
        self.currency_entity =  currency_entity
        self.currency_numeric_code = currency_numeric_code
        self.currency_minor_unit = currency_minor_unit
    }

    func description() -> String {
        return "Currency [Name: \(currency_name), Symbol: \(currency_symbol), Short Name: \(currency_alphabetic_code), Entity: \(currency_entity), Numeric Code: \(currency_numeric_code), Minor Unit: \(currency_minor_unit)]"
    }

    func update(currency_name: String, currency_symbol: String, currency_alphabetic_code: String) {
        self.currency_name = currency_name
        self.currency_symbol = currency_symbol
        self.currency_alphabetic_code = currency_alphabetic_code
        self.currency_entity =  currency_entity
        self.currency_numeric_code = currency_numeric_code
        self.currency_minor_unit = currency_minor_unit
    }
}
