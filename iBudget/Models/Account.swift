//
//  Account.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Account : Codable {
    var account_id: UUID
    var account_name: String
    var account_description: String?
    var account_currency: Currency?
    var account_type:String
    var starting_balance: Double
    var is_opened: Bool
    var transactions: [Transaction] = []  // Liste de transactions
    
    init(account_id: UUID=UUID(), account_name: String="", account_description: String="", account_currency: Currency? = nil, account_type: String="Cash", starting_balance: Double=0, is_opened: Bool=true, transactions: [Transaction] = []) {
        self.account_id = account_id
        self.account_name = account_name
        self.account_description = account_description
        self.account_currency = account_currency
        self.account_type = account_type
        self.starting_balance = starting_balance
        self.is_opened = is_opened
        self.transactions = transactions
    }
    
    func describe() -> String {
        return "Account [ID: \(account_id), Name: \(account_name), Description: \( account_description), Currency: \(account_currency?.currency_alphabetic_code), Type: \(account_type), Starting balance: \(starting_balance), is Opened: \(is_opened)]"
    }
    
    func update(account_name: String, account_description: String, account_currency: Currency, account_type: String, starting_balance: Double,is_opened: Bool, transactions: [Transaction]) {
        self.account_name = account_name
        self.account_description = account_description
        self.account_currency = account_currency
        self.account_type = account_type
        self.starting_balance = starting_balance
        self.is_opened = is_opened
        self.transactions = transactions
    }
    
    func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(account_name, forKey: .account_name)
         try container.encode(starting_balance, forKey: .starting_balance)
        try container.encode(account_currency, forKey: .account_currency)
     }
    
    // Implémentation requise de Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        account_id = try container.decode(UUID.self, forKey: .account_id)
        account_name = try container.decode(String.self, forKey: .account_name)
        starting_balance = try container.decode(Double.self, forKey: .starting_balance)
        account_id = try container.decode(UUID.self, forKey: .account_id)
        account_description = nil
        if let currency = try? container.decode(Currency.self, forKey: .account_currency) {
                account_currency = currency
            } else {
                account_currency = nil // Si la valeur est null dans le JSON, assignez nil à account_currency
            }
        account_type = "Cash"
        is_opened = true
    }
    
    // CodingKeys pour associer les propriétés aux clés du JSON/XML
    private enum CodingKeys: String, CodingKey {
        case account_id
        case account_name
        case starting_balance
        case account_currency
    }
}
