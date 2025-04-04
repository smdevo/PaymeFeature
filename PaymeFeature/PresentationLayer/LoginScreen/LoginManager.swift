//
//  AuthManager.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation
import Combine

class LoginManager: ObservableObject {
    static let shared = LoginManager()
    
    @Published var loggedInUser: User?
    @Published var users: [User] = []
    
    private init() { }
    
    func loadUsersFromJSON() {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.async {
                self.users = decodedUsers
            }
        } catch {
            print("Error decoding users: \(error)")
        }
    }
}


import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    let balance: Double
    let userName: String
    let password: String
    let date: TimeInterval
    var friends: [User]? = []
    let cardNumber: String?
    let avatar: String?
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

