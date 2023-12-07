//
//  Category.swift
//  MyAppController
//
//  Created by Antoine Himpens on 28/10/2023.
//


import SwiftUI
import SwiftData

@Model class Category {
    var name: String
    var iconName: String
    var subcategories: [Subcategory]

    init(name: String="", iconName: String = "circle", subcategories: [Subcategory] = []) {
        self.name = name
        self.iconName = iconName
        self.subcategories = subcategories
    }
}

@Model class Subcategory {
    var name: String
    // Ajoutez un initialiseur ici si vous avez d'autres propriétés sans valeurs par défaut

    init(name: String) {
        self.name = name
    }
}
