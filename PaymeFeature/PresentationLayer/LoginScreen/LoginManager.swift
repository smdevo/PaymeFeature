//
//  AuthManager.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation
import Combine
import SwiftUI

class LoginManager: ObservableObject {
    
    static let shared = LoginManager()
    
    
    @Published var loggedInUser: UserModel?
    @Published var loggedNetUser: UserModel?
    
    @Published var netUsers: [UserModel] = []
    @Published var families: [FamilyModel] = []
    
    private init() {
        loadUsersFromJSON()
    }
    
    
    func loadUsersFromJSON() {
        UsersNtworkinDataService.shared.getData(link: "users/") { [weak self] (users: [UserModel]?) in
            guard let users else { return }
            self?.netUsers = users
            }
    }

}





