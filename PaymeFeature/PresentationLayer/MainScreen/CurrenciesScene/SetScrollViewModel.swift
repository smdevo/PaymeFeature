//
//  SetScrollViewModel.swift
//  PaymeFeature
//
//  Created by Samandar on 09/04/25.
//

import SwiftUI

class SetScrollViewModel: ObservableObject {
    
    @Published var currencies: [Currency] = []

    private let server = CurrencyNetworkingService()
   
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        server.fetchSelectedCurrencies(codes: ["USD","EUR","RUB","GBP"]) { currencies in
            guard let currencies else
            {
                return
            }
            self.currencies = currencies
        }
        
    }
    
}
