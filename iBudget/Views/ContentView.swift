
import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 0
    let exportData = ExportData() // Instance de ExportData

    var body: some View {
        TabView(selection: $selectedTab) {
           ListAccountsView()
                .tabItem {
                    Text("Accounts")
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(0)
            ListTransactionsView()
                .tabItem {
                    Text("Transactions")
                    Image(systemName: "calendar")
                }
                .tag(1)
            
            ListPayeesView()
                .tabItem {
                    Text("Payees")
                    Image(systemName: "cart")
                }
                .tag(2)

            ListCategoriesView()
                .tabItem {
                    Text("Catégories")
                    Image(systemName: "car.fill")
                }
                .tag(3)
           
            ListBudgetsView()
                .tabItem {
                    Text("Budgets")
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(4)
            
            ListTagsView()
                .tabItem {
                    Text("Tags")
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(5)
            
            ListCurrenciesView()
                .tabItem {
                    Text("Currencies")
                    Image(systemName: "dollarsign.circle")
                }
                .tag(6)

            ImportFromBank()
                .tabItem {
                    Text("QIF")
                    Image(systemName: "dollarsign.circle")
                }
                .tag(7)

            // Onglet de réglages pour l'export et l'import
            SettingsView(exportData: exportData)
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gear")
                }
                .tag(8) // Assurez-vous que le tag est unique
        }
    }
}

struct SettingsView: View {
    var exportData: ExportData // Référence à l'instance de ExportData
    @Environment(\.modelContext) var modelContext
    @Query var accounts: [Account]

    var body: some View {
        VStack {
            Button("Exporter les données") {
                // Appeler la fonction d'exportation
                // Remplacez ceci par la récupération de vos données réelles à exporter
                exportData.BackupData(accounts: accounts)
            }

            Button("Importer les données") {
                // Appeler la fonction d'importation
                let exportData = ExportData()
                if let restoredAccounts = exportData.RestoreData() {
                    for account in restoredAccounts {
                        modelContext.insert(account)
                    }
                }
            }
        }
    }
}
