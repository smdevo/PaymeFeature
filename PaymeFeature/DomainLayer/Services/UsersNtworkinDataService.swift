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
    var balance: String
}


import Foundation


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
    
   
}
