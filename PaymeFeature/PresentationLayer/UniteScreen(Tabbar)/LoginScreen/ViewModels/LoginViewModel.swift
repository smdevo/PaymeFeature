//
//  LoginViewModel.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    let netSerVice = UsersNtworkinDataService.shared
    
    @Published var users: [UserModel] = []
    
    //TODO: MOCK
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    var onLoginSuccess: (() -> Void)?
    var onChildLoginSuccess: (() -> Void)?
    
    init() {
        getUsers()
    }
    
    
    func getUsers() {
        netSerVice.getData(link: "users") { [weak self] (users: [UserModel]?) in
            guard let users else {
                
                return
            }
            self?.users = users
        }
    }
    
    func check() -> Bool? {
        
        let trimmedUserName = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !users.isEmpty else {
            errorMessage = "No Internet"
            return nil
        }
        errorMessage = ""
        
        
        if let user = users.first(where: {
            $0.number.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
            
            UserDefaults.standard.set(user.id, forKey: "userId")
            UserDefaults.standard.set(user.familyId, forKey: "userFamilyId")
            UserDefaults.standard.set(user.role, forKey: "role")
            
            return user.role
            
        } else {
            errorMessage = "Неверный логин или пароль"
            return nil
        }
        
    }
    
    
    func loginToMain() {
        
        guard let isPareent = check() else {
            return
        }
        
        if isPareent {
            switchToMain()
        } else {
            errorMessage = "It is not parnet's account"
        }
       
    }
    
    func loginToChild() {
        
        guard let isPareent = check() else {
            return
        }
        
        if !isPareent {
            switchToChild()
        }else {
            errorMessage = "It is not child's account"
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
    
    func switchToChild() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let childAccountView = ChildAccountView()
                .environmentObject(GlobalViewModel())
            let hostingController = UIHostingController(rootView: childAccountView)
            window.rootViewController = hostingController
            window.makeKeyAndVisible()
        }
    }
    
}

