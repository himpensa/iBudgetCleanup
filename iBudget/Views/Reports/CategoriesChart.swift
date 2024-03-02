//
//  CategoriesChart.swift
//  iBudget
//
//  Created by Antoine Himpens on 08/02/2024.
//

import SwiftUI
import Charts

struct CategoriesChart: View {
    var dataTransactions : [Transaction] = []
    
    @State private var selectedCount: Int?
    @State private var selectedSector: String?
    
    private var categoryTransactions: [(name: String, amount: Double)] {
        let groupedDict = Dictionary(grouping: dataTransactions, by: { $0.transaction_category!.category_name })
        let categoryAmounts = groupedDict.map { (name, transactions) in
            let totalAmount = transactions.reduce(0) { $0 + $1.transaction_amount }
            let roundedAmount = totalAmount.rounded(toPlaces: 2) // Arrondir à deux chiffres après la virgule
            print(roundedAmount)
            return (name: name, amount: roundedAmount)
        }
        return categoryAmounts
    }

    
    init(transactions : [Transaction]) {
        self.dataTransactions = transactions
    }
    
    var body: some View {
        VStack {
            Chart {
                ForEach(categoryTransactions, id: \.name) { category in
                    SectorMark(
                        angle: .value("Cup", category.amount),
                        innerRadius: .ratio(0.4),
                        outerRadius: .inset(10),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value("Type", category.name))
                    .cornerRadius(10.0)
                    .annotation(position: .overlay) {
                        //Text("\(category.amount)")
                        Text("\(category.amount, format: .number.precision(.fractionLength(0)))")

                    }
                    .opacity(selectedSector == nil ? 1.0 : (selectedSector == category.name ? 1.0 : 0.5))
                }
            }

            .chartAngleSelection(value: $selectedCount)
            
            .onChange(of: selectedCount) { oldValue, newValue in
                if let newValue {
                    selectedSector = findSelectedSector(value: newValue)
                } else {
                    selectedSector = nil
                }
                print(selectedCount)
                print(selectedSector)
            }
        }
        .padding()
    }
    
    private func findSelectedSector(value: Int) -> String? {
     
        var accumulatedCount = 0
     
        let coffee = categoryTransactions.first { (_, count) in
            accumulatedCount += Int(count)
            return value <= accumulatedCount
        }
     
        return coffee?.name
    }
}

// Extension pour arrondir à un certain nombre de chiffres après la virgule
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
