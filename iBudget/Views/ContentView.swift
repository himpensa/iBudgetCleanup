
import SwiftData
import UniformTypeIdentifiers
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
    @Query var currencies: [Currency]
    @Query var transactions: [Transaction]
    @Query var tags: [Tag]
    @Query var payees: [Payee]
    @Query var budgets: [Budget]
    
    var body: some View {
        VStack {
            Button("Exporter les données") {
                let dataContainer = DataContainer(categories: categories, accounts: accounts, currencies: currencies, transactions: transactions)
                encodeData(data: dataContainer, toFile: "data.json")
            }
            Button("Importer les données") {
                if let decodedData: DataContainer = decodeData(fromFile: "data.json") {
                    for category in decodedData.categories {
                        if !categoryExistsInCurrentData(category: category) {
                            modelContext.insert(category)
                            print("Category ajoutée: \(category.category_name)")
                        } else {
                            print("Category déjà présente: \(category.category_name)")
                        }                    }
                    for account in decodedData.accounts {
                        if !accountExistsInCurrentData(account: account) {
                            modelContext.insert(account)
                            print("Account ajouté: \(account.account_name)")
                        } else {
                            print("Account déjà présent: \(account.account_name)")
                        }
                    }
                    for transaction in decodedData.transactions {
                        if !transactionExistsInCurrentData(transaction: transaction) {
                            modelContext.insert(transaction)
                            print("Transaction ajouté: \(transaction.transaction_details)")
                        } else {
                            print("Transaction déjà présent: \(transaction.transaction_details)")
                        }
                    }
                    for currency in decodedData.currencies {
                        if !currencyExistsInCurrentData(currency: currency) {
                            modelContext.insert(currency)
                            print("Currency ajouté: \(currency.currency_alphabetic_code)")
                        } else {
                            print("Currency déjà présent: \(currency.currency_alphabetic_code)")
                        }
                    }
                    
                }
            }
        }
    }
}




extension SettingsView {
    private func categoryExistsInCurrentData(category: Category) -> Bool {
        return categories.contains(where: { $0.category_id == category.category_id })
    }
    private func accountExistsInCurrentData(account: Account) -> Bool {
        return accounts.contains(where: { $0.account_id == account.account_id })
    }
    private func transactionExistsInCurrentData(transaction: Transaction) -> Bool {
        return transactions.contains(where: { $0.transaction_id == transaction.transaction_id })
    }
    private func currencyExistsInCurrentData(currency: Currency) -> Bool {
        return currencies.contains(where: { $0.currency_id == currency.currency_id })
    }
    private func payeeExistsInCurrentData(payee: Payee) -> Bool {
        return payees.contains(where: { $0.payee_id == payee.payee_id })
    }
    private func tagExistsInCurrentData(tag: Tag) -> Bool {
        return tags.contains(where: { $0.tag_id == tag.tag_id })
    }
    private func budgetExistsInCurrentData(budget: Budget) -> Bool {
        return budgets.contains(where: { $0.budget_id == budget.budget_id })
    }
}
