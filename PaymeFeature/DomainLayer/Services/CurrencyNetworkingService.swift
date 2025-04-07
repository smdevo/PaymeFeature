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
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
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
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
    
}



