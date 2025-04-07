//
//  NetworkingCurrencyService.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import Foundation

final class CurrencyNetworkingService {
    
    private let linkUrl = "https://cbu.uz/uz/arkhiv-kursov-valyut/json/"
    
    func fetchSelectedCurrencies(codes: [String] = ["USD","EUR","RUB"], all: Bool = false, completion: @escaping ([Currency]?) -> Void) {
        guard let url = URL(string: linkUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let allCurrencies = try decoder.decode([Currency].self, from: data)
                
                let selectedCurrencies = all ? allCurrencies : allCurrencies.filter { codes.contains($0.currency) }
                
                DispatchQueue.main.async {
                    completion(selectedCurrencies)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    
    
}



