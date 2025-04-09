//
//  AuthManager.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation
import Combine
import SwiftUI

class LoginManager: ObservableObject {
    
    static let shared = LoginManager()
    
//    @Published var loggedInUser: UserModel = UserModel(name: "qwe", number: "qwe", password: "", date: 0, familyId: "qwe", role: false, balance: "0", id: "666")
    
    @Published var loggedInUser: User?
    @Published var users: [User] = []
    
    @Published var loggedNetUser: UserModel?
    
    @Published var netUsers: [UserModel] = []
    @Published var families: [FamilyModel] = []
    
    private init() {
        loadUsersFromJSON()
    }
    
    

    func loadUsersFromJSON() {
        
        
        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
            guard let users else { return }
            
            self?.netUsers = users
            }
        
        UsersNtworkinDataService.shared.fetchFamilies { [weak self] families in
            guard let families else { return }
            
            self?.families = families
        }
        
        
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            DispatchQueue.main.async {
                self.users = decodedUsers
            }
        } catch {
            print("Error decoding users: \(error)")
        }
    }

}





