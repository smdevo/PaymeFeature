//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation
import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var friends: [User]
    var allUsers: [User]
    
    init(currentUser: User, allUsers: [User]) {
        self.friends = currentUser.friends ?? []
        self.allUsers = allUsers
    }

    
    init() {
        self.friends = []
        self.allUsers = []
    }
    
    func addFriend(byCardNumber cardNumber: String) {
        guard !cardNumber.isEmpty else { return }
        if let friend = allUsers.first(where: { $0.cardNumber == cardNumber }) {
            if !friends.contains(where: { $0.id == friend.id }) {
                friends.append(friend)
            }
        }
    }
}

