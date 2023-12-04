import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)

            AddView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(2)

            HelpView()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(3)
        }
    }
}

// Vue pour la rubrique "Home"
struct HomeView: View {
    var body: some View {
        VStack {
            Text("Accueil")
                .font(.largeTitle)
            Spacer()
        }
    }
}

// Vue pour la rubrique "Ajouter"
struct AddView: View {
    var body: some View {
        VStack {
            Text("Ajouter")
                .font(.largeTitle)
            Spacer()
        }
    }
}

// Vue pour la rubrique "Paramètres"
struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Paramètres")
                .font(.largeTitle)
            Spacer()
        }
    }
}

// Vue pour la rubrique "Aide"
struct HelpView: View {
    var body: some View {
        VStack {
            Text("Aide")
                .font(.largeTitle)
            Spacer()
        }
    }
}


#Preview {
    ContentView()
}
