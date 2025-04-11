//
//  Trash.swift
//  PaymeFeature
//
//  Created by Samandar on 10/04/25.
//


//final class NetCache {
//    
//    @Published var users: [UserModel] = []
//    @Published var families: [FamilyModel] = []
//    @Published var currentUser: UserModel?
//    @Published var currentFamily: FamilyModel?
//    
//    
//    static let shared = NetCache()
//    
//    let netserVice = UsersNtworkinDataService.shared
//    
//    init() {
//        setUsers()
//        setFamilies()
//    }
//    
//    func setUsers() {
//        netserVice.getData(link: "users/") { [weak self] (users: [UserModel]?) in
//            guard let users else {
//                print("Cant get users")
//                return
//            }
//            
//            self?.users = users
//        }
//    }
//    
//    func setFamilies() {
//        
//        netserVice.getData(link: "families/") { [weak self] (families: [FamilyModel]?) in
//            guard let families else {
//                print("Cant get families")
//                return
//            }
//            
//            self?.families = families
//        }
//    }
//    
//    func setCurrentUser(id: String) {
//        netserVice.getData(link: "users/" + id) { [weak self] (user: UserModel?) in
//            guard let user else {
//                print("Cant get user")
//                return
//            }
//            
//            self?.currentUser = user
//        }
//    }
//    
//    func setCurrentFamily(id: String) {
//        netserVice.getData(link: "families/" + id) { [weak self] (family: FamilyModel?) in
//            guard let family else {
//                print("Cant get user")
//                return
//            }
//            
//            self?.currentFamily = family
//        }
//    }
//    
//}




//import Foundation
//import Combine
//import SwiftUI
//
//class LoginManager: ObservableObject {
//    
//    static let shared = LoginManager()
//    
//    
//    @Published var users: [User] = []
//    
//    @Published var loggedNetUser: UserModel?
//    
//    @Published var netUsers: [UserModel] = []
//    @Published var families: [FamilyModel] = []
//    
//    private init() {
//        loadUsersFromJSON()
//    }
//    
//    
//
//    func loadUsersFromJSON() {
//        
//        
//        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
//            guard let users else { return }
//            
//            self?.netUsers = users
//            }
//        
//        UsersNtworkinDataService.shared.fetchFamilies { [weak self] families in
//            guard let families else { return }
//            
//            self?.families = families
//        }
//        
//        
//        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
//            return
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            let decodedUsers = try decoder.decode([User].self, from: data)
//            DispatchQueue.main.async {
//                self.users = decodedUsers
//            }
//        } catch {
//            print("Error decoding users: \(error)")
//        }
//    }
//
//}
