//
//  Currency.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Currency: Codable {
    var currency_id: UUID
    var currency_name: String
    var currency_symbol: String
    var currency_alphabetic_code: String
    var currency_numeric_code: String
    var currency_minor_unit: Int

    init(currency_id: UUID = UUID(),currency_name: String = "", currency_symbol: String = "", currency_alphabetic_code: String = "", currency_numeric_code: String = "", currency_minor_unit: Int = 2) {
        self.currency_id = currency_id
        self.currency_name = currency_name
        self.currency_symbol = currency_symbol
        self.currency_alphabetic_code = currency_alphabetic_code
        self.currency_numeric_code = currency_numeric_code
        self.currency_minor_unit = currency_minor_unit
    }

    func description() -> String {
        return "Currency [ID: \(currency_id), Name: \(currency_name), Symbol: \(currency_symbol), Short Name: \(currency_alphabetic_code), Numeric Code: \(currency_numeric_code), Minor Unit: \(currency_minor_unit)]"
    }

    func update(currency_name: String, currency_symbol: String, currency_alphabetic_code: String, currency_numeric_code : String, currency_minor_unit: Int) {
        self.currency_name = currency_name
        self.currency_symbol = currency_symbol
        self.currency_alphabetic_code = currency_alphabetic_code
        self.currency_numeric_code = currency_numeric_code
        self.currency_minor_unit = currency_minor_unit
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let decodedID = try? values.decode(UUID.self, forKey: .currency_id) {
            self.currency_id = decodedID // Utilise si c'est un UUID valide
        } else {
            self.currency_id = UUID() // Si non valide ou absent, génère un nouvel UUID
        }
        currency_name = try values.decode(String.self, forKey: .currency_name)
        currency_symbol = try values.decode(String.self, forKey: .currency_symbol)
        currency_alphabetic_code = try values.decode(String.self, forKey: .currency_alphabetic_code)
        currency_numeric_code = try values.decode(String.self, forKey: .currency_numeric_code)
        currency_minor_unit = try values.decode(Int.self, forKey: .currency_minor_unit)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currency_id, forKey: .currency_id)
        try container.encode(currency_name, forKey: .currency_name)
        try container.encode(currency_symbol, forKey: .currency_symbol)
        try container.encode(currency_numeric_code, forKey: .currency_numeric_code)
        try container.encodeIfPresent(currency_alphabetic_code, forKey: .currency_alphabetic_code)
        try container.encode(currency_minor_unit, forKey: .currency_minor_unit)

    }

    enum CodingKeys: String, CodingKey {
        case currency_id
        case currency_name
        case currency_symbol
        case currency_alphabetic_code
        case currency_numeric_code
        case currency_minor_unit
    }
}
