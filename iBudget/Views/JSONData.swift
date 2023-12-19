//
//  JSONData.swift
//  iBudget
//
//  Created by Antoine Himpens on 18/12/2023.
//

import Foundation

struct DataContainer: Codable {
    var categories: [Category]
    var accounts: [Account]
}

func encodeData(data: DataContainer, toFile file: String) {
    do {
        let encoder = JSONEncoder()
        
        let fileManager = FileManager.default

        // Chemin vers le répertoire Documents (pour les applications iOS/macOS)
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(file)

        // Créer le fichier si nécessaire
        if !fileManager.fileExists(atPath: fileURL.path) {
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        }
        print(fileURL)
        
        if let encoded = try? encoder.encode(data) {
            try? encoded.write(to: fileURL, options: .atomic)
        }
            } catch {
                print("Erreur lors de la sérialisation : \(error)")
            }


}

func decodeData(fromFile file: String) -> DataContainer? {
    do {
        let fileManager = FileManager.default

        // Chemin vers le répertoire Documents (pour les applications iOS/macOS)
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(file)
               
        print(fileURL)

        // Vérifiez si le fichier existe avant d'essayer de le lire
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("Le fichier accounts.xml n'existe pas.")
            return nil
        }
        
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            print(try decoder.decode(DataContainer.self, from: data))
            if let decoded = try? decoder.decode(DataContainer.self, from: data) {
                return decoded
            }
        }
        return nil

    } catch {
        print("Erreur lors de la désérialisation : \(error)")
        return nil
    }
}
