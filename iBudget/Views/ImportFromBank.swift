import SwiftUI
import UniformTypeIdentifiers
import SwiftData

struct ImportFromBank: View {
    @State private var isFilePickerPresented = false
    @Query var transactions: [Transaction]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Transaction]()


    var body: some View {
        VStack {
            List(transactions, id: \.transaction_details) { transaction in
                VStack(alignment: .leading) {
                    Text("Date: \(transaction.transaction_date)")
                    Text("Amount: \(transaction.transaction_amount)")
                    Text("Description: \(transaction.transaction_details)")
                }
            }
            Button("Importer un fichier QIF") {
                isFilePickerPresented = true
            }
        }
        .fileImporter(isPresented: $isFilePickerPresented, allowedContentTypes: [UTType(filenameExtension: "qif")!]) { result in
            switch result {
            case .success(let url):
                importQIF(from: url)
            case .failure(let error):
                print("Erreur lors de l'importation du fichier : \(error)")
            }
        }
    }
    
    func importQIF(from fileURL: URL){
        let qifString = try? String(contentsOf: fileURL)

        let lines = qifString!.split(separator: "\n")
        //var transactions = [Transaction]()
        var date: Date?
        var amount: Double?
        var description: String?

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        for line in lines {
            if line.hasPrefix("D") {
                date = dateFormatter.date(from: String(line.dropFirst()))
            } else if line.hasPrefix("T") {
                amount = Double(line.dropFirst())
            } else if line.hasPrefix("P") {
                description = String(line.dropFirst())
            } else if line == "^" {
                if let date = date, let amount = amount, let description = description {
                    print(description)
                    let transaction = Transaction(transaction_details: description, transaction_date: date, transaction_amount: amount, transaction_currency: Currency(),transaction_account: Account())
                    modelContext.insert(transaction)
                    path = [transaction]
                }
                date = nil
                amount = nil
                description = nil
                print(transactions.first?.transaction_details)
                
            }
        }
    }
}


