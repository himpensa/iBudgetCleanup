//
//  EditDestinationView.swift
//  iBudget
//
//  Created by Antoine Himpens on 11/11/2023.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Bindable var category: Category
    let icons = ["cup.and.saucer.fill",
                 "scissors.circle",
                 "sportscourt.circle",
                 "pawprint.circle",
                 "car.circle",
                 "scissors.circle",
                 "gamecontroller.circle",
                 "rectangle.stack.person.crop.circle",
                 "app.circle",
                 "printer.fill.and.paper.fill",
                 "person.circle",
                 "laptopcomputer.circle",
                 "cart.circle",
                 "network.circle",
                 "pencil.circle",
                 "Sglobe.europe.africa.circle",
                 "app.circle",
                 "camera.circle",
                 "wrench.circle",
                 "person.2.circle",
                 "book.circle",
                 "music.note.circle",
                 "film.circle",
                 "desktopcomputer.circle",
                 "leaf.circle",
                 "paintbrush.pointed.circle",
                 "cross.case.circle",
                 "pills.circle",
                 "bus.circle",
                 "car.circle",
                 "person.crop.circle",
                 "cart.circle",
                 "camera.circle",
                 "paintpalette.circle",
                 "guitars.circle"
                 ] // Liste des icônes SF Symbols disponibles
    
    var body: some View {
        Form {
            TextField("Name", text: $category.name)
            
            Picker("Icon", selection: $category.iconName) {
                ForEach(icons, id: \.self) { icon in
                    Label(icon, systemImage: icon)
                }
            }
            
        }
        
        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}
