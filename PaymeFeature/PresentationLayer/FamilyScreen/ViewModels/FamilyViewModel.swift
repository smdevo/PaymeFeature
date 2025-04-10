//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?
    
    @Published var familyMembers: [UserModel] = []

    
    @Published var allUsers: [UserModel] = []
    
    @Published var familyCard: VirtualCardModel?
    
    let userId = UserDefaults.standard.string(forKey: "userId") ?? "1"
    
    
    
    init() {
        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
            guard let users else { return }
            self?.currentUser = users.first(where: {$0.id == self?.userId})
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
            }
        
        UsersNtworkinDataService.shared.fetchFamilies { [weak self] families in
            guard let families else { return }
                
            self?.familyCard = families.filter({$0.members.contains(self!.userId)}).first?.virtualcard
            }
    }

}

