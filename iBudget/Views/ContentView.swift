
import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 0

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

            ImportTransactionsFromQIF()
                .tabItem {
                    Text("QIF")
                    Image(systemName: "dollarsign.circle")
                }
                .tag(7)

            // Onglet de réglages pour l'export et l'import
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gear")
                }
                .tag(8) // Assurez-vous que le tag est unique
        }
    }
}

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @Query var accounts: [Account]
    
    var body: some View {
        VStack {
            Button("Exporter les données") {
                // Appeler la fonction d'exportation
                // Remplacez ceci par la récupération de vos données réelles à exporter
                // Créer une structure contenant les deux tableaux
                let dataContainer = DataContainer(categories: categories, accounts: accounts)

                  // Encoder et sauvegarder les données dans data.json
                  encodeData(data: dataContainer, toFile: "data.json")

            }

            Button("Importer les données") {
                // Appeler la fonction d'importation
                // Décoder les données depuis data.json
                if let decodedData: DataContainer = decodeData(fromFile: "data.json") {
                    for category in decodedData.categories {
                        print("Category: \(category.category_name)")
                        modelContext.insert(category)
                    }
                    for account in decodedData.accounts {
                        print("Account: \(account.account_name)")
                        modelContext.insert(account)
                    }

                }
            }
        }
    }
}
