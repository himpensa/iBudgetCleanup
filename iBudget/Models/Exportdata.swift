import Foundation
import XMLCoder

class ExportData {
    
    // Exporte les données au format XML
    func BackupData(accounts: [Account]) {
        let encoder = XMLEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        do {
            let data = try encoder.encode(accounts, withRootKey: "accounts", header: XMLHeader(version: 1.0, encoding: "UTF-8"))
            // Écriture du fichier XML (à adapter selon l'emplacement souhaité)
            try data.write(to: URL(fileURLWithPath: "path/to/accounts.xml"))
        } catch {
            print("Erreur lors de la sérialisation : \(error)")
        }
    }

    // Importe les données depuis un fichier XML
    func RestoreData() -> [Account]? {
        let decoder = XMLDecoder()

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "path/to/accounts.xml"))
            let accounts = try decoder.decode([Account].self, from: data, withRootKey: "accounts")
            return accounts
        } catch {
            print("Erreur lors de la désérialisation : \(error)")
            return nil
        }
    }
}
