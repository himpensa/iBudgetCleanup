//
//  ExportData.swift
//  iBudget
//
//  Created by Antoine Himpens on 09/12/2023.
//

import Foundation
import XMLCoder

class ExportData {
    
    // Exporte les données au format XML
    func BackupData(accounts: [Account]) {
        let encoder = XMLEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        do {
            let data = try encoder.encode(accounts)
            let fileManager = FileManager.default

            // Chemin vers le répertoire Documents (pour les applications iOS/macOS)
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent("accounts.xml")

            // Créer le fichier si nécessaire
            if !fileManager.fileExists(atPath: fileURL.path) {
                fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            }

            // Écriture des données dans le fichier
            try data.write(to: fileURL)
            print(fileURL)
        } catch {
            print("Erreur lors de la sérialisation : \(error)")
        }
    }


    // Importe les données depuis un fichier XML
    func RestoreData() -> [Account]? {
        let decoder = XMLDecoder()
        
        do {
            let fileManager = FileManager.default

            // Chemin vers le répertoire Documents (pour les applications iOS/macOS)
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent("accounts.xml")
            
            print(fileURL)

            // Vérifiez si le fichier existe avant d'essayer de le lire
            guard fileManager.fileExists(atPath: fileURL.path) else {
                print("Le fichier accounts.xml n'existe pas.")
                return nil
            }

            // Lecture des données depuis le fichier
            let data = try Data(contentsOf: fileURL)
            let accounts = try decoder.decode([Account].self, from: data)
            return accounts
        } catch {
            print("Erreur lors de la désérialisation : \(error)")
            return nil
        }
    }

}
