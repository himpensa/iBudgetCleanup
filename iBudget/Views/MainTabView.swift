import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView
        {
            NavigationView {
                ScrollView {
                    VStack {
                        GroupBox(label: Label("Budget", systemImage: "dollarsign")) {
                            BudgetTileView()
                        }
                        GroupBox(label: Label("Répartition des Dépenses", systemImage: "chart.pie")) {                           
                            CategoriesTileView()
                        }
                        GroupBox(label: Label("Planned Expense", systemImage: "calendar")) {
                            PlannedTileView()
                        }
                        GroupBox(label: Label("Last Transactions", systemImage: "dollarsign")) {
                          TransactionsTileView()
                        }
                    }
                    .padding()
                }
            }
            .tabItem {
                Label("Summary", systemImage: "house")
            }.tag(1)
            
            
            MenuView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }.tag(2)
        }
    }
}

#Preview {
    ContentView()
}
