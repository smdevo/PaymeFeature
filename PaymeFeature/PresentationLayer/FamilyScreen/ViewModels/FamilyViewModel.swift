//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?/* = UserModel(name: "Sam", number: "", password: "", date: 1, familyId: "", role: false, balance: "", id: "")*/
    
    @Published var familyMembers: [UserModel] = [] //{
//        didSet {
//            a()
//        }
//    }
    
    
    init() {
        
        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
            guard let users else { return }
            
            let id = UserDefaults.standard.string(forKey: "idUser") ?? "4"
            
            self?.currentUser = users.first(where: {$0.id == id})
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
            }
        print(familyMembers)
    }
    
    
//    func a() {
//        print(familyMembers)
//    }
//    
//    
}

