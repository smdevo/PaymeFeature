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
            }
        } catch {
            print("Error decoding users: \(error)")
        }
    }

}





