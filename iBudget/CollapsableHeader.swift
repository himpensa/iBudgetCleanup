//
//  ContentView.swift
//  iBudget
//
//  Created by Antoine Himpens on 15/02/2024.
//

import SwiftUI

struct CollapsableHeader: View {
    @State private var headerHeight: CGFloat = 300
    let minHeight: CGFloat = 50

    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        if geometry.frame(in: .global).minY <= 0 {
                            Group {
                                Text("Mon Compte Courant")
                                Text("Solde: $3,250.00")
                                Text("Dépenses récentes")
                            }
                            .padding()
                            .opacity(Double(1 + geometry.frame(in: .global).minY / headerHeight))
                        } else {
                            Group {
                                Text("Mon Compte Courant")
                                Text("Solde: $3,250.00")
                                Text("Dépenses récentes")
                            }
                            .padding()
                        }
                    }
                    .frame(width: geometry.size.width, height: max(minHeight, headerHeight + geometry.frame(in: .global).minY))
                    .background(Color.blue)
                    .clipped()
                    .animation(.easeInOut, value: geometry.frame(in: .global).minY)
                }
                .frame(height: headerHeight)

                ForEach(0..<50) { item in
                    HStack {
                        Text("Transaction \(item)")
                            .lineLimit(1)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableHeader()
    }
}
