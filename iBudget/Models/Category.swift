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
    var parent: Category?

    init(name: String="", iconName: String = "circle") {
        self.name = name
        self.iconName = iconName
    }
}
