import SwiftUI

struct PlannedTileView: View {
    var body: some View {
            VStack() {
                ForEach(0..<3) { index in
                    PlannedTransactionRow(categoryColor: Color.blue, transactionTitle: "Nom de la transaction", transactionAmount: "1320,15 €",
                        transactionDate: "26/01")
                }
            }

    }
}

struct PlannedTransactionRow: View {
    var categoryColor: Color
    var transactionTitle: String
    var transactionAmount: String
    var transactionDate: String
    
    var body: some View {
        HStack() {
            Rectangle()
                .fill(categoryColor)
                .frame(width: 5, height: 30, alignment: .leading)
            
                Text(transactionTitle)
                    .font(.headline)
                
            Spacer()
            
            Text(transactionAmount)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(transactionDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
    }
}

struct PlannedTileView_Previews: PreviewProvider {
    static var previews: some View {
        PlannedTileView()
    }
}
