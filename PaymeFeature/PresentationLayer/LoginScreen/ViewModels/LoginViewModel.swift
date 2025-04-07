//
//  LoginViewModel.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var loggedInUser: User?
    @Published var errorMessage: String?
    
    var users: [User] = []
    
    init() {
        loadUsers()
    }
    
    func loadUsers() {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            errorMessage = "Файл users.json не найден"
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let loadedUsers = try JSONDecoder().decode([User].self, from: data)
            self.users = loadedUsers
        } catch {
            errorMessage = "Ошибка загрузки данных: \(error.localizedDescription)"
        }
    }
    
    func login() {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let user = users.first(where: { $0.userName.lowercased() == trimmedUserName && $0.password == trimmedPassword }) {
            loggedInUser = user
            errorMessage = nil
        } else {
            errorMessage = "Неверный логин или пароль"
        }
    }
}
