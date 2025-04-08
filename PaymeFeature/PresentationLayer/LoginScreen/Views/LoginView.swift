//
//  LoginView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    @FocusState private var isUsernameFieldFocused: Bool
    
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
                    .focused($isUsernameFieldFocused)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .focused($isUsernameFieldFocused)
                
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
        }
        .onReceive(viewModel.$errorMessage) { err in
            if let err = err {
                print("Ошибка логина: \(err)")
            }
        }
        .onAppear {
            viewModel.onLoginSuccess = {
                switchToMain()
            }
        }
    }
    
    func logout() {
        
    }
    
    func switchToMain() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let tabBarController = UniteViewController()
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}



