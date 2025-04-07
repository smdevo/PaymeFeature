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
        .onAppear {
            LoginManager.shared.loadUsersFromJSON()
        }
    }
    
    func login() {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let user = LoginManager.shared.users.first(where: {
            $0.userName.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
            LoginManager.shared.loggedInUser = user
       
        } else {
            errorMessage = "Неверный логин или пароль"
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

