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
                print("Loaded users: \(self.users.count)")
            }
        } catch {
            print("Error decoding users: \(error)")
        }
    }

}


struct User: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    var balance: Double
    let userName: String
    let password: String
    let date: TimeInterval
    var friends: [User]? = []
    let cardNumber: String?
    let avatar: String?
    let role: String
    var transactions: [Transaction]? = []
    var subscriptions: [Subscription]? = []
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}



