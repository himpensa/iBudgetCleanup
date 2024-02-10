
import SwiftUI

struct BudgetTileView: View {
    @State private var amount = 100.0
    
    private let minValue = 0.0
    private let maxValue = 570.0
    
    let gradient = Gradient(colors: [.green, .red])
    
    
    
    
    
    var body: some View {
            HStack {
                VStack {
                    Gauge(value: amount, in: minValue...maxValue) {
                        Label("Amount", systemImage: "thermometer.medium")
                    } currentValueLabel: {
                        Text(Int(amount), format: .number)
                            .foregroundColor(.green)
                        
                    } minimumValueLabel: {
                        Text("")
                            .foregroundColor(.green)
                        
                    } maximumValueLabel: {
                        Text("570")
                            .foregroundColor(.red)
                        
                    }
                    .tint(gradient)
                }
                .gaugeStyle(.accessoryCircular)
                Spacer()
                HStack {
                    Label("", systemImage: "10.square")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 40))
                    
                        Text("17 € / Jour restant")
                    }
            }
    }
    
}
struct BudgetTileView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBox() {
            BudgetTileView()
        }
        .groupBoxStyle(PersoGroupBoxStyle(destination: ListBudgetsView()))    }
}
