//
//  Currency.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//

import SwiftUI
import SwiftData

@Model class Currency {
    var name: String
    var currency_symbol: String
    var short_name: String

    init(name: String = "", currency_symbol: String = "", short_name: String = "") {
        self.name = name
        self.currency_symbol = currency_symbol
        self.short_name = short_name
    }

    func description() -> String {
        return "Currency [Name: \(name), Symbol: \(currency_symbol), Short Name: \(short_name)]"
    }

    func update(name: String, currency_symbol: String, short_name: String) {
        self.name = name
        self.currency_symbol = currency_symbol
        self.short_name = short_name
    }

    static func fromXML(xmlString: String) -> [Currency] {
        let parser = CurrencyXMLParser(xml: xmlString)
        return parser.parse()
    }
}

class CurrencyXMLParser: NSObject, XMLParserDelegate {
    private var xml: String
    private var currencies: [Currency] = []
    private var currentCurrency: Currency?
    private var currentElement: String?
    let symbols: [String: String] = [
        "ALL": "Lek",
        "AFN": "؋",
        "ARS": "$",
        "AWG": "ƒ",
        "AUD": "$",
        "AZN": "₼",
        "BSD": "$",
        "BBD": "$",
        "BYN": "Br",
        "BZD": "BZ$",
        "BMD": "$",
        "BOB": "$b",
        "BAM": "KM",
        "BWP": "P",
        "BGN": "лв",
        "BRL": "R$",
        "BND": "$",
        "KHR": "៛",
        "CAD": "$",
        "KYD": "$",
        "CLP": "$",
        "CNY": "¥",
        "COP": "$",
        "CRC": "₡",
        "HRK": "kn",
        "CUP": "₱",
        "CZK": "Kč",
        "DKK": "kr",
        "DOP": "RD$",
        "XCD": "$",
        "EGP": "£",
        "SVC": "$",
        "EUR": "€",
        "FKP": "£",
        "FJD": "$",
        "GHS": "¢",
        "GIP": "£",
        "GTQ": "Q",
        "GGP": "£",
        "GYD": "$",
        "HNL": "L",
        "HKD": "$",
        "HUF": "Ft",
        "ISK": "kr",
        "INR": "₹",
        "IDR": "Rp",
        "IRR": "﷼",
        "IMP": "£",
        "ILS": "₪",
        "JMD": "J$",
        "JPY": "¥",
        "JEP": "£",
        "KZT": "лв",
        "KPW": "₩",
        "KRW": "₩",
        "KGS": "лв",
        "LAK": "₭",
        "LBP": "£",
        "LRD": "$",
        "MKD": "ден",
        "MYR": "RM",
        "MUR": "₨",
        "MXN": "$",
        "MNT": "₮",
        "MZN": "MT",
        "NAD": "$",
        "NPR": "₨",
        "ANG": "ƒ",
        "NZD": "$",
        "NIO": "C$",
        "NGN": "₦",
        "NOK": "kr",
        "OMR": "﷼",
        "PKR": "₨",
        "PAB": "B/.",
        "PYG": "Gs",
        "PEN": "S/.",
        "PHP": "₱",
        "PLN": "zł",
        "QAR": "﷼",
        "RON": "lei",
        "RUB": "₽",
        "SHP": "£",
        "SAR": "﷼",
        "RSD": "Дин.",
        "SCR": "₨",
        "SGD": "$",
        "SBD": "$",
        "SOS": "S",
        "ZAR": "R",
        "LKR": "₨",
        "SEK": "kr",
        "CHF": "CHF",
        "SRD": "$",
        "SYP": "£",
        "TWD": "NT$",
        "THB": "฿",
        "TTD": "TT$",
        "TRY": "₺",
        "TVD": "$",
        "UAH": "₴",
        "AED": "د.إ",
        "GBP": "£",
        "USD": "$",
        "UYU": "$U",
        "UZS": "лв",
        "VEF": "Bs",
        "VND": "₫",
        "YER": "﷼",
        "ZWD": "Z$"
    ]

    init(xml: String) {
        self.xml = xml
    }

    func parse() -> [Currency] {
        if let data = xml.data(using: .utf8) {
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        return currencies
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "CcyNtry" {
            currentCurrency = Currency(name: "", currency_symbol: "", short_name: "")
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let currentCurrency = currentCurrency, let currentElement = currentElement else { return }
        switch currentElement {
        case "CcyNm":
            currentCurrency.name = string
        case "Ccy":
            currentCurrency.short_name = string
            currentCurrency.currency_symbol = symbols[string, default: ""]
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "CcyNtry", let currentCurrency = currentCurrency {
            currencies.append(currentCurrency)
            self.currentCurrency = nil
        }
    }
}




