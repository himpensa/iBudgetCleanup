import SwiftUI

struct MainTabView: View {

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
                ListTransactionsView()
                .tabItem {
                    Text("Reports")
                    Image(systemName: "chart.line.uptrend.xyaxis.circle")
                }
                .tag(1)
            ListTransactionsView()
                .tabItem {
                    Text("Transactions")
                    Image(systemName: "arrow.left.arrow.right.circle")
                }
                .tag(2)
            ListTransactionsView()
                .tabItem {
                    Text("Planned")
                    Image(systemName: "calendar.circle")
                }
                .tag(3)
            ListBudgetsView()
                .tabItem {
                    Text("Budgets")
                    Image(systemName: "gauge.low")
                }
                .tag(4)
            MenuView()
                .tabItem {
                    Text("More")
                    Image(systemName: "ellipsis")
                }
                .tag(5)
        }
    }
}

