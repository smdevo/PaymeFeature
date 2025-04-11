//
//  UsersNtworkinDataService.swift
//  PaymeFeature
//
//  Created by Samandar on 09/04/25.
//


struct UserModel: Codable, Identifiable, Equatable {
    let name: String
    let number: String
    let password: String
    let date: Int
    var familyId: String
    let role: Bool
    let balance: String
    let id: String
    let invitation: Bool
    let cardNumber: String
}

struct FamilyModel: Codable {
    let name: String
    var members: [String]
    var virtualcard: VirtualCardModel?
    let id: String
}

struct VirtualCardModel: Codable {
    var id: String = ""
    var name: String = ""
    var number: String = ""
    var ownerPhoneNumber: String = ""
    var balance: String = ""
}


import Foundation

//NO NEED
final class NetService {
    
    static var shared: NetService = NetService()
    
    @Published var users: [UserModel] = []
    @Published var families: [FamilyModel] = []
    
    @Published var neededFamily: FamilyModel?

    
    init() {
        
        refreshBase()
        
    }
    
    func refreshBase() {
        gettingUsers()
        gettingFamilies()
    }
    
    
    func gettingUsers() {
        //isLoading = true
        
        NetManager.shared.get(url: NetManager.API_Users) { [weak self] (result: Result<[UserModel],Error>)  in
            switch result {
                
            case .success(let users):
                self?.users = users
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
    func gettingFamilies()  {
        
        NetManager.shared.get(url: NetManager.API_Families) { [weak self] (result: Result<[FamilyModel],Error>)  in
            switch result {
                
            case .success(let families):
                self?.families = families
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func getFamily(id: String) {
        
        NetManager.shared.get(url: NetManager.API_Families) { [weak self] (result: Result<FamilyModel,Error>)  in
            switch result {
                
            case .success(let family):
                self?.neededFamily = family
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
}




final class UsersNtworkinDataService {
    
    private let serVerLink = "https://67ecf2e64387d9117bbb9a32.mockapi.io/"
    private let linkUsers = "https://67ecf2e64387d9117bbb9a32.mockapi.io/users"
    private let linkFamilies = "https://67ecf2e64387d9117bbb9a32.mockapi.io/families"
    
    
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

    
    
    func patchData<T: Codable>(link: String, dataToUpdate: T, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: serVerLink + link) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH" 
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(dataToUpdate)
            
            // Вывод для отладки
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Отправляем JSON (PATCH): \(jsonString)")
            }
            
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка PATCH: \(error.localizedDescription)")
                    DispatchQueue.main.async { completion(false) }
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("PATCH HTTP статус-код: \(httpResponse.statusCode)")
                }
                DispatchQueue.main.async { completion(true) }
            }.resume()
        } catch {
            print("Ошибка кодирования при PATCH: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    
    func postData<T: Codable>(link: String, dataToSend: T, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: serVerLink + link) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"  // Используем POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(dataToSend)
            
            // Вывод для отладки
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Отправляем JSON (POST): \(jsonString)")
            }
            
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка POST: \(error.localizedDescription)")
                    DispatchQueue.main.async { completion(false) }
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("POST HTTP статус-код: \(httpResponse.statusCode)")
                }
                
                DispatchQueue.main.async { completion(true) }
            }.resume()
        } catch {
            print("Ошибка кодирования при POST: \(error.localizedDescription)")
            completion(false)
        }
    }


    
    
    
    
}
