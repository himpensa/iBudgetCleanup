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
    var subcategories: [Subcategory]

    init(name: String="", subcategories: [Subcategory] = []) {
        self.name = name
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
