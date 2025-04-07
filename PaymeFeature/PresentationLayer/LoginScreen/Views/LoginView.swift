//
//  LoginView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            if let loggedUser = LoginManager.shared.loggedInUser {
                // Если пользователь уже авторизован
                Text("Вы уже авторизованы как \(loggedUser.name)")
                    .font(.title)
                Button("Выйти") {
                    logout()
                }
                .foregroundColor(.red)
            } else {
                // Форма для авторизации
                Text("Авторизация")
                    .font(.largeTitle)
                
                TextField("Username", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Войти") {
                    login()
                }
                .padding()
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
        LoginManager.shared.loadUsersFromJSON()
            print("LoginView onAppear. Users count: \(LoginManager.self).shared.users.count)")
        }
    }
    
    func login() {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let user = LoginManager.shared.users.first(where: {
            $0.userName.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
        LoginManager.shared.loggedInUser = user
            switchToMain()
        } else {
            errorMessage = "Неверный логин или пароль"
        }
    }
    
    func logout() {
    (LoginManager).shared.loggedInUser = nil
        userName = ""
        password = ""
        errorMessage = nil
    }
    
    func switchToMain() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let tabBarController = UniteViewController() // Ваш таббар-контроллер
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
