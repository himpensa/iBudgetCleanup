//
//  AppInit.swift
//  iBudget
//
//  Created by Antoine Himpens on 10/02/2024.
//

import Foundation
import SwiftUI
import SwiftData

class AppInit: ObservableObject {
    @Environment(\.modelContext) var modelContext
    
    // Créez une clé statique pour vérifier si c'est le premier lancement
    private static let isFirstLaunchKey = "isFirstLaunch"
    
    // Utilisez un @Published propriété pour surveiller l'état de lancement de l'application
    @Published var isFirstLaunch: Bool {
        didSet {
            UserDefaults.standard.set(isFirstLaunch, forKey: Self.isFirstLaunchKey)
        }
    }
    
    // Initialisateur pour la classe
    init() {
        // Vérifiez si c'est le premier lancement de l'application
        isFirstLaunch = UserDefaults.standard.bool(forKey: Self.isFirstLaunchKey)
        
        // Si c'est le premier lancement, configurez les valeurs par défaut
        if isFirstLaunch {
            // Exemple de configuration de valeurs par défaut
            configureDefaultValues()
            
            // Marquez que ce n'est plus le premier lancement
            isFirstLaunch = false
        }
    }
    
    // Fonction pour configurer les valeurs par défaut
    private func configureDefaultValues() {
        // Exemple de configuration de valeurs par défaut
        UserDefaults.standard.set("defaultValue", forKey: "exampleKey")
    }
}
