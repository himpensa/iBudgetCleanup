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

          }
    }
}
#Preview {
    ContentView()
}
