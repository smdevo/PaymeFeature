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
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Введите номер телефона")
                .fontWeight(.bold)
            
            
            Text("Чтобы войти или зарегистрироваться")
                .fontWeight(.light)
            
            PhoneNumberField(phoneNumber: $viewModel.phoneNumber)
            
            SecureField("Password", text: $viewModel.password)
                       .padding(8)
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.gray, lineWidth: 1)
                       )
            Spacer()
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Войти")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    .ignoresSafeArea(edges: .bottom)
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            viewModel.onLoginSuccess = {
                switchToMain()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(10)
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



#Preview{
    LoginView()
}


