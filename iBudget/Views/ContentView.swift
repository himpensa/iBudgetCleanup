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
                    Image(systemName: "calendar")
                }
                .tag(3)
            ListCurrenciesView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                }
                .tag(0)

            ListPayeesView()
                .tabItem {
                    Image(systemName: "cart")
                }
                .tag(1)

            ListCategoriesView()
                .tabItem {
                    Image(systemName: "car.fill")
                }
                .tag(2)

           
            ListBudgetsView()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(4)
            ListTagsView()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(5)
          }
    }
}
#Preview {
    ContentView()
}
