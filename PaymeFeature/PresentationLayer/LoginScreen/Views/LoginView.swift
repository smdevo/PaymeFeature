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
            
            Text("Авторизация")
                .font(.largeTitle)
            
            TextField("Phone number", text: $viewModel.userName)
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
        .onAppear {
            viewModel.onLoginSuccess = {
                switchToMain()
            }
        }
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



