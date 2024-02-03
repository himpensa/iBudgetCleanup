    //
    //  SimpleTransactionsPerCategoryView.swift
    //  iBudget
    //
    //  Created by Antoine Himpens on 23/01/2024.
    //

    import SwiftUI
    import Charts

    struct BudgetBurndownCartView: View {
        let data = [
            (name: "01/01", amount: 12, total: 100),
            (name: "02/01", amount: 4, total: 88),
            (name: "03/01", amount: 6, total: 82),
            (name: "04/01", amount: 2, total: 80),
            (name: "05/01", amount: 7, total: 73),
            (name: "06/01", amount: 0, total: 73),
            (name: "07/01", amount: 2, total: 71),
            (name: "08/01", amount: 0, total: 71),
            (name: "09/01", amount: 3, total: 68),
            (name: "10/01", amount: 4, total: 64),
            (name: "11/01", amount: 5, total: 59),
            (name: "12/01", amount: 4, total: 55),
            (name: "13/01", amount: 0, total: 55),
            (name: "14/01", amount: 3, total: 52),
            (name: "15/01", amount: 0, total: 52),
            (name: "16/01", amount: 2, total: 50),
            (name: "17/01", amount: 0, total: 50),
            (name: "18/01", amount: 3, total: 47),
            (name: "19/01", amount: 0, total: 47),
            (name: "20/01", amount: 0, total: 47),
            (name: "21/01", amount: 3, total: 44),
            (name: "22/01", amount: 4, total: 40),
            (name: "23/01", amount: 5, total: 35),
            (name: "24/01", amount: 0, total: 35),
            (name: "25/01", amount: 10, total: 25),
            (name: "26/01", amount: 0, total: 25),
            (name: "27/01", amount: 4, total: 21),
            (name: "28/01", amount: 0, total: 21),
            (name: "29/01", amount: 4, total: 17),
            (name: "30/01", amount: 0, total: 17),
            (name: "31/01", amount: 2, total: 15)
        ]
        
        @State var xScrollPosition: Double = 0

        var body: some View {

            Chart(data, id: \.name) { name, amount, total in
                BarMark(x: PlottableValue.value("Day", name), y: PlottableValue.value("Amount", amount))
               
                
            }
            .chartScrollableAxes(.horizontal)
            .chartScrollTargetBehavior(.valueAligned(unit: 2))
            .aspectRatio(contentMode: .fit)
            .padding()
        }
        
    }


#Preview {
    BudgetBurndownCartView()
}
