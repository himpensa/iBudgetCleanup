//
//  UtilsView.swift
//  iBudget
//
//  Created by Antoine Himpens on 04/02/2024.
//

import SwiftUI

struct PersoGroupBoxStyle<Destination: View>: GroupBoxStyle {
    var destination: Destination
    @Environment(\.colorScheme)
     var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        NavigationLink(destination: destination) {
            GroupBox(label: configuration.label) {
                configuration.content.padding(.top)
            }
            .buttonStyle(PlainButtonStyle())
            .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(white: colorScheme == .light ? 1 : 0.1)
                                    .shadow(.inner(color: .white.opacity(0.5), radius: 0.25, x: 0, y: 0.5)))
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
        }
    }
}

struct SimplePersoGroupBoxStyle<Destination: View>: GroupBoxStyle {
    var destination: Destination
    
    func makeBody(configuration: Configuration) -> some View {
        NavigationLink(destination: destination) {
            GroupBox(label: configuration.label) {
                configuration.content.padding(.top)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}



struct UtilsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        GroupBox() {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .groupBoxStyle(SimplePersoGroupBoxStyle(destination: ContentView()))
    }
}

#Preview {
    UtilsView()
}
