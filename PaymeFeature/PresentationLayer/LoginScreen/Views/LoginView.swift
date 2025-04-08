//
//  LoginView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if let loggedUser = LoginManager.shared.loggedInUser {
                Text("Вы уже авторизованы как \(loggedUser.name)")
                    .font(.title)
                Button("Выйти") {
                    logout()
                }
                .foregroundColor(.red)
            } else {
                Text("Авторизация")
                    .font(.largeTitle)
                
                TextField("Username", text: $viewModel.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Войти") {
                    viewModel.login()
                }
                .padding()
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            LoginManager.shared.loadUsersFromJSON()
            print("LoginView onAppear. Users count: \(LoginManager.shared.users.count)")
        }
        .onReceive(viewModel.$errorMessage) { err in
            if let err = err {
                print("Ошибка логина: \(err)")
            }
        }
        .onAppear {
            // Устанавливаем обратный вызов
            viewModel.onLoginSuccess = {
                switchToMain()
            }
        }
    }
    
    func logout() {
        LoginManager.shared.loggedInUser = nil
    }
    
    func switchToMain() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let tabBarController = UniteViewController() // Ваш таббар-контроллер
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            print("Переход на таббар. Logged in user: \(LoginManager.shared.loggedInUser?.name ?? "nil")")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

