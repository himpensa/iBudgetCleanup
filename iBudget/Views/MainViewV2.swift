//
//  MainViewV2.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/02/2024.
//

import SwiftUI

struct MainViewV2: View {
    @State var selection = 1
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                BudgetTileView()
                    .badge(2)
                    .tabItem {
                        Label("Received", systemImage: "tray.and.arrow.down.fill")
                    }
                    .tag(1)
                CategoriesTileView()
                    .tabItem {
                        Label("Sent", systemImage: "tray.and.arrow.up.fill")
                    }
                    .tag(2)
                PlannedTileView()
                    .tabItem {
                        Label("Sent", systemImage: "tray.and.arrow.up.fill")
                    }
                    .tag(3)
            }
            .navigationTitle("test")
        }
    }
}

#Preview {
    MainViewV2()
}
