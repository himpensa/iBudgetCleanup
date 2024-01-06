import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ListTransactionsView()
                .tabItem {
                    Text("Transactions")
                    Image(systemName: "calendar")
                }
                .tag(0)

           
            MenuView()
                .tabItem {
                    Text("More")
                    Image(systemName: "ellipsis")
                }
                .tag(4)
            
 
        }
    }
}

