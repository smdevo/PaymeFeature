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
    @Published var errorMessage: String?
    
    // Обратный вызов, который будет установлен из View и вызван после успешного логина.
    var onLoginSuccess: (() -> Void)?
    
    func login() {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("Попытка логина: \(trimmedUserName) / \(trimmedPassword)")
        print("Всего пользователей: \(LoginManager.shared.users.count)")
        for user in LoginManager.shared.users {
            print("Пользователь: \(user.userName), пароль: \(user.password)")
        }
        
        if let user = LoginManager.shared.users.first(where: {
            $0.userName.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
            LoginManager.shared.loggedInUser = user
            print("Успешный логин: \(user.name), friends count: \(user.friends?.count ?? 0)")
            // Вызываем обратный вызов, чтобы сообщить View о том, что логин успешен
            onLoginSuccess?()
        } else {
            errorMessage = "Неверный логин или пароль"
            print("Неверный логин или пароль")
        }
    }
}
