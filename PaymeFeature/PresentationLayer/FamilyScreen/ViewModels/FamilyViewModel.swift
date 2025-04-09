//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    @Published var familyMembers: [User]
    @Published var hasPendingInvitation: Bool = false
    var allUsers: [User]
    var currentUser: User
    
    
    init(currentUser: User, allUsers: [User]) {
        self.currentUser = currentUser
        self.allUsers = allUsers
        self.familyMembers = allUsers
    }
    
}

