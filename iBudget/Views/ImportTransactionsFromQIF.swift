import SwiftUI
import UniformTypeIdentifiers
import SwiftData

struct ImportTransactionsFromQIF: View {
    @State private var isFilePickerPresented = false
    @Query var transactions: [Transaction]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Transaction]()
    @Query(sort: [SortDescriptor(\Currency.currency_name)]) var currencies: [Currency]
    @Query var accounts: [Account]  // Récupérer la liste des comptes
    @State private var selectedCurrency: Currency?
    @State private var selectedAccount: Account?
    @State private var currencyLoaded = false
    
    
    var body: some View {
        VStack {
            
            Section(header: Text("Amount and Currency")) {
                if currencyLoaded{
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency.currency_name).tag(currency as Currency?)
                    }
                }
            }
                else{
                    Text("Currency Loading")
                }
                    
            }

            Section(header: Text("Account")) {
                Picker("Account", selection: $selectedAccount) {
                    ForEach(accounts, id: \.self) { account in
                        Text(account.account_name).tag(account as Account?)
                    }
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
        .onAppear{
            loadCurrencies()
        }
    }
    
    func loadCurrencies(){
        DispatchQueue.main.async {
            if let defaultCurrency = currencies.first(where: { $0.currency_is_default }) {
                self.selectedCurrency = defaultCurrency
                print("ok")
            }
            self.currencyLoaded = true
        }
    }
    
    func importQIF(from fileURL: URL){
            fileURL.startAccessingSecurityScopedResource()
        
        let qifString = try? String(contentsOf: fileURL)

        do  {
            let qifString = try String(contentsOf: fileURL)
            let lines = qifString.split(separator: "\n")
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
                    let transaction = Transaction(transaction_details: description, transaction_date: date, transaction_amount: amount, transaction_currency: selectedCurrency,transaction_account: selectedAccount,transaction_category: nil)
                    modelContext.insert(transaction)
                    path = [transaction]
                }
                date = nil
                amount = nil
                description = nil
                print(transactions.first?.transaction_details)
                
            }
        }
        } catch {
            print("Erreur lors de la lecture du fichier : \(error)")
        }
        fileURL.stopAccessingSecurityScopedResource()


    }
        
}


