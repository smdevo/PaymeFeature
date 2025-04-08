//
//  AllCurreniesView.swift
//  PaymeFeature
//
//  Created by Samandar on 07/04/25.
//

import SwiftUI


final class AllCurreniesViewModel: ObservableObject {
    
    @Published var currencies: [Currency] = []

    private let server = CurrencyNetworkingService()
   
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        server.fetchSelectedCurrencies(all: true) { currencies in
            guard let currencies else { return }
            
            self.currencies = currencies
        }
        
    }
    
    
}


struct AllCurreniesView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AllCurreniesView()
}
