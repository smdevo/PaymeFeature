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
    
    var onLoginSuccess: (() -> Void)?
    
    func login() {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for user in LoginManager.shared.users {
            print("Пользователь: \(user.userName), пароль: \(user.password)")
        }
        
        if let user = LoginManager.shared.users.first(where: {
            $0.userName.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
            LoginManager.shared.loggedInUser = user
            onLoginSuccess?()
        } else {
            errorMessage = "Неверный логин или пароль"
        }
    }
}
