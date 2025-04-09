//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    @Published var familyMembers: [User]
    var allUsers: [User]
    var currentUser: User
    
    init(currentUser: User, allUsers: [User]) {
        self.currentUser = currentUser
        self.allUsers = allUsers
        self.familyMembers = allUsers
    }
    
    init() {
        self.currentUser = User(id: "0", name: "", age: 0, balance: 0.0, userName: "", password: "", date: 0, friends: [], cardNumber: nil, avatar: nil, role: "", transactions: [], subscriptions: [])
        self.familyMembers = []
        self.allUsers = []
    }
    
}

extension FamilyViewModel {
    func updateFamily() {
        if let currentUser = LoginManager.shared.loggedInUser {
            self.familyMembers = currentUser.friends ?? []
        }
    }
}

