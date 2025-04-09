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
    let familyId: String
    let role: Bool
    let balance: String
    let id: String
    let invitation: Bool
}

struct FamilyModel: Codable {
    let name: String
    let members: [String]
    let virtualcard: VirtualCardModel
    let id: String
}

struct VirtualCardModel: Codable {
    let id: String
    let name: String
    let number: String
    let ownerPhoneNumber: String
}




import Foundation

final class UsersNtworkinDataService {
    
    private let linkUsers = "https://67ecf2e64387d9117bbb9a32.mockapi.io/users"
    private let linkFamilies = "https://67ecf2e64387d9117bbb9a32.mockapi.io/families"
    
    
    static let shared = UsersNtworkinDataService()
    
    func fetchUsers(completion: @escaping ([UserModel]?) -> Void) {
        
        
        guard let url = URL(string: linkUsers) else {
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
                let allUsers = try decoder.decode([UserModel].self, from: data)
                
                DispatchQueue.main.async {
                    completion(allUsers)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    
    func fetchFamilies(completion: @escaping ([FamilyModel]?) -> Void) {
        guard let url = URL(string: linkFamilies) else {
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
                let allfamilies = try decoder.decode([FamilyModel].self, from: data)
                
                DispatchQueue.main.async {
                    completion(allfamilies)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
}
