import SwiftUI

struct TransactionsTileView: View {
    var body: some View {
            VStack() {
                ForEach(0..<3) { index in
                    TransactionRow(categoryColor: Color.blue, transactionTitle: "Nom de la transaction", transactionAmount: "1320,15 €",
                        transactionDate: "26/01")
                }
            }
    }
}

struct TransactionRow: View {
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

struct TransactionsTileView_Previews: PreviewProvider {
    static var previews: some View {
        PlannedTileView()
    }
}
