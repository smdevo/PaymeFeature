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
    @Published var userName: String = "John Smith"
    @Published var password: String = "john123"
    @Published var errorMessage: String?
    
    var onLoginSuccess: (() -> Void)?
    
    init() {
        getUsers()
    }
    
    
    func getUsers() {
        netSerVice.getData(link: "users") { [weak self] (users: [UserModel]?) in
            guard let users else {
                print("Cant get users in login Page")
                return
            }
            self?.users = users
        }
    }
    
    
    func login() {
        
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !users.isEmpty else {
            errorMessage = "No Internet"
            return
        }
        errorMessage = ""

        if let user = users.first(where: {
            $0.name.lowercased() == trimmedUserName && $0.password == trimmedPassword
        }) {
            
            UserDefaults.standard.set(user.id, forKey: "userId")
            UserDefaults.standard.set(user.familyId, forKey: "userFamilyId")

            
            onLoginSuccess?()
        } else {
            errorMessage = "Неверный логин или пароль"
        }
    }
}



//import SwiftUI
//import Combine
//
//class LoginViewModel: ObservableObject {
//    
//    
//    let netCache = NetCache.shared
//    var cancellables = Set<AnyCancellable>()
//    
//    
//    @Published var users: [UserModel] = []
//    
//    //TODO: MOCK
//    @Published var userName: String = "John Smith"
//    @Published var password: String = "john123"
//    @Published var errorMessage: String?
//    
//    var onLoginSuccess: (() -> Void)?
//    
//    init() {
//        settingSubscriptions()
//    }
//    
//    func settingSubscriptions() {
//        
//        netCache.$users
//            .sink { users in
//                self.users = users
//            }
//            .store(in: &cancellables)
//        
//    }
//    
//    
//    func login() {
//        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard !users.isEmpty else {
//            errorMessage = "No Internet"
//            return
//        }
//        errorMessage = ""
//        
//        for user in users {
//            print("Пользователь: \(user.name), пароль: \(user.password)")
//        }
//        
//        if let user = users.first(where: {
//            $0.name.lowercased() == trimmedUserName && $0.password == trimmedPassword
//        }) {
//            UserDefaults.standard.set(user.id, forKey: "userId")
//            
//            netCache.setCurrentUser(id: user.id)
//            
//            UserDefaults.standard.set(user.familyId, forKey: "userFamilyId")
//            
//            netCache.setCurrentFamily(id: user.familyId)
//            
//            onLoginSuccess?()
//        } else {
//            errorMessage = "Неверный логин или пароль"
//        }
//    }
//}
