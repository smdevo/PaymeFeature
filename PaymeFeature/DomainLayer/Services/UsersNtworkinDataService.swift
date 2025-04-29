//
//  UsersNtworkinDataService.swift
//  PaymeFeature
//
//  Created by Samandar on 09/04/25.
//

import Foundation

final class UsersNtworkinDataService {
    
    private let serVerLink = "https://67ecf2e64387d9117bbb9a32.mockapi.io/"
    static let shared = UsersNtworkinDataService()
    
    func getData<T: Codable>(link: String, completion: @escaping (T?) -> Void) {
        
        guard let url = URL(string: serVerLink + link) else {
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
                let allData = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(allData)
                }
            } catch {
                completion(nil)
            }
        }.resume()

        
    }
    
    
    
    func updateData<T: Codable>(link: String, dataToUpdate: T, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: serVerLink + link) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(dataToUpdate)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }.resume()
        } catch {
            completion(false)
        }
    }


    func postData<T: Codable>(link: String, dataToSend: T, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: serVerLink + link) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(dataToSend)

            
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async { completion(true) }
            }.resume()
        } catch {
            completion(false)
        }
    }
        
}
        


