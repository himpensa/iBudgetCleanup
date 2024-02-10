import SwiftUI

struct AccountWeatherTileView: View {
    var account_name: String
    var balance: Double
    var last_transaction_date: String
    var forecasted_balance: Double
    
    var body: some View {
                HStack {
                    Text(account_name.uppercased())
                        .foregroundColor(.primary)
                        .font(.headline)
                        .padding(-10)

                    Spacer()
                    weatherSymbol(for: balance)
                    .font(.system(size: 30))
                    .padding(-10)

                }
                HStack {
                    Text(" \(String(format: "%.f",balance)) €")
                        .foregroundColor(balanceColor(for: balance))
                        .font(.system(size: 30))
                        .padding(-10)

                    Spacer()
                    
                    Text("AU \(last_transaction_date)")
                        .foregroundColor(.secondary)
                     .font(.system(size: 15))
                     .padding(-10)

                }
              
                HStack{
                    Text("Solde prévisionnel: \(String(format: "%.2f",forecasted_balance)) €".uppercased())
                        .foregroundColor(.primary)
                     .font(.system(size: 15))
                     .padding(-10)
                    Spacer()
                }
    }
    
    private func weatherSymbol(for balance: Double) -> some View {
        let weatherIcon: String
        let iconColor: Color
        switch balance {
        case let x where x > 100:
            weatherIcon = "sun.max"
            iconColor = .yellow
        case let x where x < 0:
            weatherIcon = "cloud.bolt.rain"
            iconColor = .gray
        default:
            weatherIcon = "cloud.sun"
            iconColor = .white
        }
        
        return Image(systemName: weatherIcon)
            .foregroundColor(iconColor)
    }

private func balanceColor(for balance: Double) -> Color {
    let balanceColor: Color
    
    switch balance {
    case let x where x > 100:
        balanceColor = .green
    case let x where x < 0:
        balanceColor = .red
    default:
        balanceColor = .black
    }
    
    return balanceColor
}





}

struct AccountWeatherTileView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBox() {
            AccountWeatherTileView(
                account_name: "Compte Courant",
                balance: 150.0,
                last_transaction_date: "01/01/2024",
                forecasted_balance: 200.0
            )
        }
        .groupBoxStyle(PersoGroupBoxStyle(destination: ListBudgetsView()))
        
    }
}


