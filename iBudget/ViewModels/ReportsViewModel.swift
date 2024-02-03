//
//  ReportsViewModel.swift
//  iBudget
//
//  Created by Antoine Himpens on 24/01/2024.
//

import SwiftUI

struct ReportsViewModel {
}

struct BudgetChartValue: Identifiable {
    let id = UUID().uuidString
    let name: String
    let value: Int

    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
}
